import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInterface {
  Future<DocumentSnapshot>? getDocument() {
    return null;
  }

  Future<List<QueryDocumentSnapshot<Object?>>>? getDocsInCollection() {
    return null;
  }

  Future<void>? addDocument() {
    return null;
  }

  Future<void>? updateDocument() {
    return null;
  }

  // void getDocument() {}

  // void getDocsInCollections() {}

  // void addDocument() {}

  // void updateDocument() {}
}
