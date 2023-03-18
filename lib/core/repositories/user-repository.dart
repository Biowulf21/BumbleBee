import 'dart:io';

import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/core/wrappers/firebase_singleton.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:bumblebee/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'firestore_repository.dart';

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
      });
      FirebaseSingleton().getAuth.currentUser!.sendEmailVerification();
      return const Right('User successfully created.');
    } on SocketException {
      return const Left(Failure(
        message: 'Cannot create user. No internet connection.',
      ));
    }
  }

  Future<Either<Failure, User?>> getUserInfo({required String userID}) async {
    try {
      final userDoc = await FirestoreRepository(firestoreInstance)
          .getDocument(collectionID: 'users', documentID: userID);

      return userDoc.fold(
        (failCase) {
          return Left(failCase);
        },
        (user) {
          userRoles? result = userRoles.values.firstWhere((e) {
            return e.toString() == user?['role'];
          });
          return Right(User(
            firstName: user?['firstName'],
            middleName: user?['middleName'],
            lastName: user?['lastName'],
            email: user?['email'],
            contactNumber: user?['contactNumber'],
            role: result,
          ));
        },
      );
    } on SocketException {
      return const Left(Failure(
        message: 'Cannot create user. No internet connection.',
      ));
    } on FirebaseException catch (e) {
      return Left(Failure(message: e.message!));
    } catch (e) {
      // handle any other unexpected errors here
      return const Left(Failure(message: 'Unknown error occurred.'));
    }
  }
}
