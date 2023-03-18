import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:bumblebee/feature/manage%20properties/domain/usecases/read/get_properties_usecase.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final user = MockUser();
  final auth = MockFirebaseAuth(mockUser: user);
  final firestore = FakeFirebaseFirestore();

  test('getPropertiesUseCase returns Failure because user is not authenticated',
      () async {
    final result = await GetAllPropertiesUseCase().getAllPropertiesByID(
        auth: auth, firestore: firestore, userRole: userRoles.Landlord);

    expect(result.fold((failure) => failure, (r) => null), isA<Failure>());
    expect(result.fold((failure) => failure.message, (r) => null),
        'No user currently logged in. Cannot get properties.');
  });

  group('getPropertiesUseCase returns Failure', () {
    setUpAll(() => auth.signInWithEmailAndPassword(
        email: 'random@example.com', password: 'random@example.com'));

    tearDown(() => auth.signOut());

    test(
        'getPropertiesUseCase returns Failure because user does not have landlord privileges',
        () async {
      final result = await GetAllPropertiesUseCase().getAllPropertiesByID(
          auth: auth, firestore: firestore, userRole: userRoles.Tenant);

      expect(
          result.fold((failure) {
            return failure;
          }, (r) => r),
          isA<Failure>());
      expect(result.fold((failure) => failure.message, (r) => null),
          'User has tenant privileges. Cannot get properties.');
    });
  });
}
