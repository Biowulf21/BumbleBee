import 'package:bumblebee/repositories/firestore-repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final instance = FakeFirebaseFirestore();

  test('Add document correctly', () async {
    final addDocTest = FirestoreRepository(instance).addDocument(
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
    final docData = snapshot.docs.first.data();
    expect(docData, {'name': 'new test user', 'age': 21, 'cash': 2000.15});
  });
}
