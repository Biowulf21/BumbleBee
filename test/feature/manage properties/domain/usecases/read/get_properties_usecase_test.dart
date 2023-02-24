import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final user = MockUser();
  final auth = MockFirebaseAuth(mockUser: user);
  final firestore = FakeFirebaseFirestore();

  group('Testing getPropertiesUseCase by getting all properties', () {
    
  });
}
