import 'dart:convert';

import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:bumblebee/repositories/firestore-repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final instance = FakeFirebaseFirestore();

  test('Add document correctly', () async {
    await FirestoreRepository(instance).addDocument(
        collectionID: 'users',
        dataMap: {'name': 'test user', 'age': 21, 'cash': 2000.15});

    final snapshot = await instance.collection('users').get();
    expect({'name': 'test user', 'age': 21, 'cash': 2000.15},
        snapshot.docs.first.data());
  });

  test('Update document correctly', () async {
    final snapshot = await instance.collection('users').get();

    await FirestoreRepository(instance).updateDocument(
        collectionID: 'users',
        dataMap: {'name': 'new test user'},
        documentName: snapshot.docs.first.id);

    final updatedDoc = await instance.collection('users').get();

    expect(updatedDoc.docs.first.get('name'), equals('new test user'));
  });

  test('Get document', () async {
    final snapshot = await instance.collection('users').get();
    final doc = snapshot.docs.first.id;
    final userObj = User(
        firstName: 'new test user',
        middleName: 'test mid name',
        lastName: 'test last name',
        email: 'test@email.com',
        contactNumber: '000000000000',
        role: userRoles.Landlord);
    final docFromFirestore = await FirestoreRepository(instance)
        .getDocument(collectionID: 'users', documentID: doc);
    expect(userObj.toJson(), {
      'firstName': 'new test user',
      'middleName': 'test mid name',
      'lastName': 'test last name',
      'email': 'test@email.com',
      'contactNumber': '000000000000',
      'role': 'userRoles.Landlord'
    });
  });

  test('Get all documents from collection', () async {
    final docs = [];
    final ids = [];
    await FirestoreRepository(instance).addDocument(
        collectionID: 'users',
        dataMap: {'name': 'user 2', 'age': 99, 'cash': 3.14});
    final snapshot = await instance.collection('users').get();
    for (var doc in snapshot.docs) {
      docs.add(doc.data());
      ids.add(doc.id);
    }
    final dumpShape = {
      "users": {
        ids[0]: {"name": "new test user", "age": 21, "cash": 2000.15},
        ids[1]: {"name": "user 2", "age": 99, "cash": 3.14}
      }
    };

    expect(jsonDecode(instance.dump()), dumpShape);
  });
}
