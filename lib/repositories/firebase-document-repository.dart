import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final FirebaseFirestore _database;

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
}
