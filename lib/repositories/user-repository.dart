import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import 'firestore-repository.dart';

class UserRepository {
  // Future<User> getUserInfo() async {
  //   return null;
  // }

  Future<void> createUserFromJSON(
      {required Map<String, dynamic> dataMap}) async {
    FirestoreRepository(FirebaseFirestore.instance)
        .addDocument(collectionID: 'users', dataMap: dataMap);
  }

  Future<void> createUserFromObject({required User userObject}) async {
    FirestoreRepository(FirebaseFirestore.instance)
        .addDocument(collectionID: 'users', dataMap: userObject.toJson());
  }
}
