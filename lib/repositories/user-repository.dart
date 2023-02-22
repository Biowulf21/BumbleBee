import 'dart:io';

import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/repositories/firestore_repository.dart';

class UserRepository {
  // Future<User> getUserInfo() async {
  //   return null;
  // }

  UserRepository({required this.firestoreInstance});
  final FirebaseFirestore firestoreInstance;

  Future<void> createUserFromJSON(
      {required Map<String, dynamic> dataMap}) async {
    try {
      FirestoreRepository(firestoreInstance)
          .addDocument(collectionID: 'users', dataMap: dataMap);
    } on SocketException {
      const Failure(
        message: 'Cannot create user. No internet connection.',
      );
    }
  }

  Future<void> createUserFromObject(
      {required User userObject, required String userID}) async {
    try {
      FirestoreRepository(firestoreInstance).addDocument(
          documentName: userID,
          collectionID: 'users',
          dataMap: {...userObject.toJson(), 'uid': userID});
    } on SocketException {
      const Failure(
        message: 'Cannot create user. No internet connection.',
      );
    }
  }

  Future<User?> getUserInfo({required String userID}) async {
    try {
      final userDoc = await FirestoreRepository(firestoreInstance)
          .getDocument(collectionID: 'users', documentID: userID);

      if (userDoc != null) {
        final Map<String, dynamic> userData = userDoc;
        userRoles? result = userRoles.values.firstWhere((e) {
          return e.toString() == userData['role'];
        });
        print(result);
        return User(
          firstName: userData['firstName'],
          middleName: userData['middleName'],
          lastName: userData['lastName'],
          email: userData['email'],
          contactNumber: userData['contactNumber'],
          role: result,
        );
      }
    } on SocketException {
      const Failure(
        message: 'Cannot create user. No internet connection.',
      );
    } on StateError catch (e) {
      print(e);
    }
    return null;
  }
}
