import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/feature/authentication/domain/repositories/auth_repository.dart';
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
  group('User creation tests', () {
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

  group('User login tests', () {
    const email = 'test@example.com';
    const password = '123456';
    final MockUser user = MockUser();
    final MockFirebaseAuth auth = MockFirebaseAuth(mockUser: user);
    final MockAuthRepository repo = MockAuthRepository();
    test('loginWithEmailAndPassword successfully logs in user', () async {
      when(repo.loginWithEmailandPassword(
              'testemail@email.com', 'Testpass123!'))
          .thenAnswer((realInvocation) {
        return Future.value(Right(user));
      });

      final result = await repo.loginWithEmailandPassword(
          'testemail@email.com', 'Testpass123!');

      expect(result.fold((l) => l, (r) => r), user);
    });

    test('loginWithEmailAndPassword returns User Not Found Error', () {
      when(repo.loginWithEmailandPassword(email, password))
          .thenThrow(FirebaseAuthException(code: 'user-not-found'));
    });

    test('loginWithEmailAndPassword returns wrong password error', () {
      when(repo.loginWithEmailandPassword(email, password))
          .thenThrow(FirebaseAuthException(code: 'wrong-password'));
    });

    test('loginWithEmailAndPassword returns wrong password error', () {
      when(repo.loginWithEmailandPassword(email, password))
          .thenThrow(FirebaseAuthException(code: 'user-disabled'));
    });
  });


  // group('', () { })
}
