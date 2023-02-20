import 'dart:io';

import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final FirebaseFirestore _database;

  // Document Getters

  FirestoreRepository(this._database);

  Future<Map<String, dynamic>?> getDocument(
      {required String collectionID, required String documentID}) async {
    try {
      final result =
          await _database.collection(collectionID).doc(documentID).get();
      return result.data();
    } on SocketException {
      Failure(
          message: 'Cannot get document. No internet connection.',
          failureCode: FailureCodes.NoInternet);
    }
    return null;
  }

  // Document Setters

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
      Failure(
          message: 'Cannot add document. No internet connection.',
          failureCode: FailureCodes.NoInternet);
    }
  }

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
      Failure(
          message: 'Cannot update document. No internet connection',
          failureCode: FailureCodes.NoInternet);
    }
  }
}
