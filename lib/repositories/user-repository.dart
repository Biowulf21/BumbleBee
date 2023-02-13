import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import 'firestore-repository.dart';

class UserRepository {
  // Future<User> getUserInfo() async {
  //   return null;
  // }

  static final firestoreInstance = FirebaseFirestore.instance;

  static Future<void> createUserFromJSON(
      {required Map<String, dynamic> dataMap}) async {
    try {
    FirestoreRepository(firestoreInstance)
        .addDocument(collectionID: 'users', dataMap: dataMap);
    } catch (e) {
      print(e); 
    }
  }

  static Future<void> createUserFromObject({required User userObject}) async {
    FirestoreRepository(firestoreInstance)
        .addDocument(collectionID: 'users', dataMap: userObject.toJson());
  }

  static Future<DocumentSnapshot<Object?>?> getUserInfo(
      {required String userID}) async {
    return FirestoreRepository(firestoreInstance)
        .getDocument(collectionID: 'users', documentID: userID);
  }
}
