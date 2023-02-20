import 'package:bumblebee/repositories/auth-repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
// ignore: unused_import
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mockito/mockito.dart';

import 'firebase_auth_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
void main() {
  test('test otin', () async {
    final MockUser user = MockUser();
    final MockFirebaseAuth auth = MockFirebaseAuth(mockUser: user);
    final MockAuthRepository repo = MockAuthRepository();

    when(repo.createAccountWithEmailAndPassword(
            'testemail@email.com', 'Testpass123!'))
        .thenAnswer((realInvocation) {
      return Future.value(Right(user));
    });

    final result = await repo.createAccountWithEmailAndPassword(
        'testemail@email.com', 'Testpass123!');

    expect(result.fold((l) => l, (r) => r), user);
    // MockFirebaseAuth auth = MockFirebaseAuth();
    // MockAuthRepository repo = MockAuthRepository();
    // final result = await repo.createAccountWithEmailAndPassword('otin', 'bla');
    // print(result);
  });
}
