import 'dart:io';

import 'package:bumblebee/errors/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final FirebaseFirestore _database;

  // Document Getters

  FirestoreRepository(this._database);

  Future<DocumentSnapshot?> getDocument(
      {required String collectionID, required String documentID}) async {
    try {
      final result =
          await _database.collection(collectionID).doc(documentID).get();
      return result;
    } on SocketException {
      Failure(
          message: 'Cannot get document. No internet connection.',
          failureCode: FailureCodes.NoInternet);
    }
    return null;
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getDocsInCollection(
      {required String collectionID}) async {
    List<QueryDocumentSnapshot<Object?>> docsInCollection = [];
    try {
      final result = await _database
          .collection(collectionID)
          .get()
          .then((QuerySnapshot snapshot) => {docsInCollection = snapshot.docs});
    } on SocketException {
      Failure(
          message: 'Cannot get documents. No internet connection.',
          failureCode: FailureCodes.NoInternet);
    }

    return docsInCollection;
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
      String? documentName}) async {
    try {
      final docRef = await _database
          .collection(collectionID)
          .doc(documentName)
          .set(dataMap);
    } on SocketException {
      Failure(
          message: 'Cannot update document. No internet connection',
          failureCode: FailureCodes.NoInternet);
    }
  }
}
