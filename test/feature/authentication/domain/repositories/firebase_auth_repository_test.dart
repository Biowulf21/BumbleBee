import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/repositories/auth-repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
// ignore: unused_import
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mockito/mockito.dart';

import 'firebase_auth_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
void main() {
  group('Auth Repository Methods on creating a User', () {
    final MockUser user = MockUser();
    final MockFirebaseAuth auth = MockFirebaseAuth(mockUser: user);
    final MockAuthRepository repo = MockAuthRepository();

    test(
        'createAccountWithEmailAndPassword successfully creates and returns a user',
        () async {
      when(repo.createAccountWithEmailAndPassword(
              'testemail@email.com', 'Testpass123!'))
          .thenAnswer((realInvocation) {
        return Future.value(Right(user));
      });

      final result = await repo.createAccountWithEmailAndPassword(
          'testemail@email.com', 'Testpass123!');

      expect(result.fold((l) => l, (r) => r), user);
    });

    test(
        'createAccountWithEmailAndPassword throws email-already-in-use FirebaseAuthException',
        () async {
      const email = 'test@example.com';
      const password = '123456';

      when(repo.createAccountWithEmailAndPassword(password, email))
          .thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

      final result =
          await repo.createAccountWithEmailAndPassword(email, password);

      // print(result);
      expect(result, isA<Either<Failure, User?>>());
    });

    test(
        'createAccountWithEmailAndPassword throws invalid-email FirebaseAuthException',
        () async {
      const email = 'test@example.com';
      const password = '123456';

      when(repo.createAccountWithEmailAndPassword(password, email))
          .thenThrow(FirebaseAuthException(code: 'invalid-email'));

      final result =
          await repo.createAccountWithEmailAndPassword(email, password);

      // print(result);
      expect(result, isA<Either<Failure, User?>>());
    });

    test(
        'createAccountWithEmailAndPassword throws weak-password FirebaseAuthException',
        () async {
      const email = 'test@example.com';
      const password = '123456';

      when(repo.createAccountWithEmailAndPassword(password, email))
          .thenThrow(FirebaseAuthException(code: 'weak-password'));

      final result =
          await repo.createAccountWithEmailAndPassword(email, password);

      // print(result);
      expect(result, isA<Either<Failure, User?>>());
    });

    test(
        'createAccountWithEmailAndPassword throws FirebaseAuthException with random erorr',
        () async {
      const email = 'test@example.com';
      const password = '123456';

      when(repo.createAccountWithEmailAndPassword(password, email))
          .thenThrow(FirebaseAuthException(code: 'operation-not-allowed:'));

      final result =
          await repo.createAccountWithEmailAndPassword(email, password);

      // print(result);
      expect(result, isA<Either<Failure, User?>>());
    });
  });
}
