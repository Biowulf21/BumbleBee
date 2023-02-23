import 'dart:io';

import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/core/wrappers/firebase_singleton.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:bumblebee/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import '../core/repositories/firestore_repository.dart';

class UserRepository {
  UserRepository({required this.firestoreInstance, required this.auth});
  final FirebaseFirestore firestoreInstance;
  final FirebaseAuth auth;

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

  Future<Either<Failure, String>> createUserFromObject(
      {required User userObject, required String password}) async {
    try {
      final result = await AuthRepository(FirebaseSingleton().getAuth)
          .createAccountWithEmailAndPassword(userObject.email, password);

      result.fold((l) {
        return const Left(Failure(
            message:
                'A problem has occurred while creating the account. Please try again later.'));
      }, (user) async {
        final otin = await FirestoreRepository(firestoreInstance).addDocument(
            documentName: user!.uid,
            successMessage: "Successfully created user.",
            collectionID: 'users',
            dataMap: {...userObject.toJson(), 'uid': user.uid});
        return const Right('User successfully created.');
      });
    } on SocketException {
      return const Left(Failure(
        message: 'Cannot create user. No internet connection.',
      ));
    }
  }

  Future<User?> getUserInfo({required String userID}) async {
    try {
      final userDoc = await FirestoreRepository(firestoreInstance)
          .getDocument(collectionID: 'users', documentID: userID);

      final userData = userDoc;
      userData.fold((failCase) {
        print(failCase.message);
      }, (successCase) {
        userRoles? result = userRoles.values.firstWhere((e) {
          return e.toString() == successCase?['role'];
        });
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
