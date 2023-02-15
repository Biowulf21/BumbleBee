import 'dart:io';

import 'package:bumblebee/errors/failure.dart';
import 'package:bumblebee/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore-repository.dart';

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
      Failure(
          message: 'Cannot create user. No internet connection.',
          failureCode: FailureCodes.NoInternet);
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
      Failure(
          message: 'Cannot create user. No internet connection.',
          failureCode: FailureCodes.NoInternet);
    }
  }

  Future<DocumentSnapshot<Object?>?> getUserInfo(
      {required String userID}) async {
    try {
      return FirestoreRepository(firestoreInstance)
          .getDocument(collectionID: 'users', documentID: userID);
    } on SocketException {
      Failure(
          message: 'Cannot create user. No internet connection.',
          failureCode: FailureCodes.NoInternet);
    }
    return null;
  }
}
