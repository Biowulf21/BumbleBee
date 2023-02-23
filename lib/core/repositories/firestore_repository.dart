import 'dart:io';

import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirestoreRepository {
  Future<Either<Failure, Map<String, dynamic>?>> getDocument(
      {required String collectionID, required String documentID});

  Future<Either<Failure, String>> addDocument(
      {required String collectionID,
      required String successMessage,
      required Map<String, dynamic> dataMap,
      String? documentName});

  Future<Either<Failure, String>> updateDocument(
      {required String collectionID,
      required String successMessage,
      required Map<String, dynamic> dataMap,
      required String documentName});
}

class FirestoreRepository implements IFirestoreRepository {
  final FirebaseFirestore _database;

  // Document Getters

  FirestoreRepository(this._database);

  @override
  Future<Either<Failure, Map<String, dynamic>?>> getDocument(
      {required String collectionID, required String documentID}) async {
    try {
      final result =
          await _database.collection(collectionID).doc(documentID).get();
      if (result.data() == null) {
        return const Left(Failure(message: 'No data found.'));
      }
      return Right(result.data());
    } on SocketException {
      return const Left(Failure(
        message: 'Cannot get document. No internet connection.',
      ));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message!));
    }
  }

  // Document Setters

  @override
  Future<Either<Failure, String>> addDocument(
      {required String collectionID,
      required String successMessage,
      required Map<String, dynamic> dataMap,
      String? documentName}) async {
    try {
      if (documentName == null) {
        final docRef = await _database.collection(collectionID).add(dataMap);
        return Right(successMessage);
      } else {
        final docRef = await _database
            .collection(collectionID)
            .doc(documentName)
            .set(dataMap);
        return Right(successMessage);
      }
    } on SocketException {
      return const Left(Failure(
          message: 'No internet connection available. Cannot create record.'));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> updateDocument(
      {required String collectionID,
      required String successMessage,
      required Map<String, dynamic> dataMap,
      required String documentName}) async {
    try {
      // Add error handling for document not existing
      final docRef = await _database
          .collection(collectionID)
          .doc(documentName)
          .update(dataMap);
      return Right(successMessage);
    } on SocketException {
      return const Left(Failure(
        message: 'Cannot update document. No internet connection',
      ));
    } on FirebaseException catch (e) {
      return Left(Failure(message: e.message!));
    }
  }
}
