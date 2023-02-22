import 'dart:io';

import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  const AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get authStateChange => _auth.idTokenChanges();

  Future<Either<Failure, User?>> loginWithEmailandPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(result.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left(
            Failure(message: 'User not found. Please try again.'));
      } else if (e.code == 'wrong-password') {
        return const Left(
            Failure(message: 'Incorrect password provided. Please try again.'));
      } else {
        return const Left(
            Failure(message: 'An exception occured. Please try again later.'));
      }
    }
  }

  Either<Failure, bool>? getVerificationStatus() {
    try {
      if (_auth.currentUser == null) {
        throw AuthException(
            'There is no user currently logged in. Please try again');
      }
      return Right(_auth.currentUser!.emailVerified);
    } on AuthException catch (e) {
      return Left(Failure(message: e.toString()));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> sendEmailVerificationMessage() async {
    try {
      if (_auth.currentUser == null) {
        _auth.currentUser!.sendEmailVerification();
      }
      return const Right('Email verification message successfully sent.');
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.toString()));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  void sendResetPasswordEmail(String email) {
    try {
      _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<Failure, User?>> createAccountWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Right(result.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return const Left(Failure(message: 'Email already in use.'));
      } else if (e.code == 'invalid-email') {
        return const Left(
            Failure(message: 'Invalid email. Please use a valid email.'));
      } else if (e.code == 'weak-password') {
        return const Left(Failure(
            message:
                'Password too weak. Please retry with a stronger password'));
      } else {
        return const Left(
            Failure(message: 'An exception occured. Please try again later.'));
      }
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on SocketException {
      const Failure(
        message: 'No internet connection. Cannot log out',
      );
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final currentUser = _auth.currentUser;
      return currentUser;
    } on SocketException {
      const Failure(
        message: 'No internet connection. Cannot get current user.',
      );
    }
    return null;
  }
}

class AuthException implements Exception {
  AuthException(this.errormessage);

  final String errormessage;
}
