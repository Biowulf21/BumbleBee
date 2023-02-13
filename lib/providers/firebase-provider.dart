import 'package:bumblebee/repositories/firebase-document-repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FirestoreDatabaseProvider = Provider((ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
});
