import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final FirebaseFirestore _database;

  FirestoreRepository(this._database);

  Future<void> getDocument(String id) async {}
}
