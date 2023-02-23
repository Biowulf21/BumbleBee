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
      final result = await FirestoreRepository(firestoreInstance).addDocument(
          collectionID: 'users',
          dataMap: dataMap,
          successMessage: "Successfully created user.");
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
          successMessage: "Successfully created user.",
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

      final userData = userDoc;
      userData.fold((failCase) {}, (successCase) {
        userRoles? result = userRoles.values.firstWhere((e) {
          return e.toString() == successCase?['role'];
        });
        print(result);
        return User(
          firstName: successCase?['firstName'],
          middleName: successCase?['middleName'],
          lastName: successCase?['lastName'],
          email: successCase?['email'],
          contactNumber: successCase?['contactNumber'],
          role: result,
        );
      });
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
