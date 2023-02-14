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
}
