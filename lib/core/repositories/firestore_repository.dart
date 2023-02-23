import 'dart:io';

import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class IFirestoreRepository {
  Future<Either<Failure, Map<String, dynamic>>> getDocument();
  Future<Either<Failure, String>> addDocument(
      {required String collectionID,
      required Map<String, dynamic> dataMap,
      String? documentName});
  Future<Either<Failure, String>> updateDocument(
      {required String collectionID,
      required Map<String, dynamic> dataMap,
      String? documentName});
}

class FirestoreRepository implements IFirestoreRepository {
  final FirebaseFirestore _database;

  // Document Getters

  FirestoreRepository(this._database);

  @override
  Future<Map<String, dynamic>?> getDocument(
      {required String collectionID, required String documentID}) async {
    try {
      final result =
          await _database.collection(collectionID).doc(documentID).get();
      return result.data();
    } on SocketException {
      const Failure(
        message: 'Cannot get document. No internet connection.',
      );
    }
    return null;
  }

  // Document Setters

  @override
  Future<void> addDocument(
      {required String collectionID,
      required Map<String, dynamic> dataMap,
      String? documentName}) async {
    try {
      if (documentName == null) {
        final docRef = await _database.collection(collectionID).add(dataMap);
      } else {
        final docRef = await _database
            .collection(collectionID)
            .doc(documentName)
            .set(dataMap);
      }
    } on SocketException {
      // Failure(
      //     message: 'Cannot add document. No internet connection.',
    }
  }

  @override
  Future<void> updateDocument(
      {required String collectionID,
      required Map<String, dynamic> dataMap,
      required String documentName}) async {
    try {
      // Add error handling for document not existing
      final docRef = await _database
          .collection(collectionID)
          .doc(documentName)
          .update(dataMap);
    } on SocketException {
      const Failure(
        message: 'Cannot update document. No internet connection',
      );
    }
  }
}
