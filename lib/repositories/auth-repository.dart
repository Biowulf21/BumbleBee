import 'dart:io';

import 'package:bumblebee/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  const AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get authStateChange => _auth.idTokenChanges();

  Future<User?> loginWithEmailandPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('User not found.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password');
      } else {
        throw AuthException('An exception occured. Please try again later.');
      }
    }
  }

  Future<User?> createAccountWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException('Email already in use.');
      } else if (e.code == 'invalid-email') {
        throw AuthException('Invalid email. Please use a valid email.');
      } else if (e.code == 'weak-password') {
        throw AuthException(
            'Password too weak. Please retry with a stronger password');
      } else {
        throw AuthException('An exception occured. Please try again later.');
      }
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on SocketException {
      Failure(
          message: 'No internet connection. Cannot log out',
          failureCode: FailureCodes.NoInternet);
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final currentUser = _auth.currentUser;
      return currentUser;
    } on SocketException {
      Failure(
          message: 'No internet connection. Cannot get current user.',
          failureCode: FailureCodes.NoInternet);
    }
    return null;
  }
}

class AuthException implements Exception {
  AuthException(this.errormessage);

  final String errormessage;
}
