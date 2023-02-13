import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final FirebaseFirestore _database;

  // Document Getters

  FirestoreRepository(this._database);

  Future<DocumentSnapshot?> getDocument(
      {required String collectionID, required String documentID}) async {
    final result = _database.collection(collectionID).doc(documentID).get();
    return result;
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getDocsInCollection(
      {required String collectionID}) async {
    List<QueryDocumentSnapshot<Object?>> docsInCollection = [];
    final result = await _database
        .collection(collectionID)
        .get()
        .then((QuerySnapshot snapshot) => {docsInCollection = snapshot.docs});

    return docsInCollection;
  }

  // Document Setters

  Future<void> addDocument(
      {required String collectionID,
      required Map<String, dynamic> dataMap,
      String? documentName}) async {
    if (documentName == null) {
      final docRef = await _database.collection(collectionID).add(dataMap);
    } else {
      final docRef = await _database
          .collection(collectionID)
          .doc(documentName)
          .set(dataMap);
    }
  }

  Future<void> updateDocument(
      {required String collectionID,
      required Map<String, dynamic> dataMap,
      String? documentName}) async {
    final docRef =
        await _database.collection(collectionID).doc(documentName).set(dataMap);
  }
}
