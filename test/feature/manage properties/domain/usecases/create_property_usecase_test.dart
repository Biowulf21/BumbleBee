import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:bumblebee/feature/manage%20properties/domain/usecases/create_property_usecase.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'create_property_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CreatePropertyUseCase>()])
void main() {
  group('Tests about adding a property', () {
    const String propertyName = "Test property";
    const PropertyType type = PropertyType.Single;
    const String address = 'Test address for the new property';

    const String email = 'test@example.com';
    const String password = '123456';
    // final createUseCase = MockCreatePropertyUseCase();
    final FakeFirebaseFirestore firestore = FakeFirebaseFirestore();
    final MockFirebaseAuth auth = MockFirebaseAuth();

    test('CreatePropertyUsecase writes to a property document on firestore.',
        () async {
      final result = await CreatePropertyUseCase().createProperty(
          name: propertyName,
          type: type,
          address: address,
          userRole: userRoles.Tenant,
          auth: auth,
          firestore: firestore);

      result.fold((failure) => print(failure.message), (successMessage) {
        expect(successMessage,
            'Successfully created new property named $propertyName');
      });
    });

    final mockCreatePropertyUseCase = MockCreatePropertyUseCase();

    test(
      'CreatePropertyUsecase throws failure when no current user is logged in.',
      () async {
        final result = await CreatePropertyUseCase().createProperty(
            name: propertyName,
            type: type,
            address: address,
            userRole: userRoles.Tenant,
            auth: auth,
            firestore: firestore);

        expect(result.fold((l) => l, (r) => r), isA<Failure>());
        expect(result.fold((l) => l, (r) => r),
            const Failure(message: 'No current user present.'));
      },
    );

    test(
      'CreatePropertyUsecase throws failure when user only has tenant privileges.',
      () async {
        final user = MockUser();
        final MockFirebaseAuth auth = MockFirebaseAuth(mockUser: user);

        final result = await CreatePropertyUseCase().createProperty(
            name: propertyName,
            type: type,
            address: address,
            userRole: userRoles.Tenant,
            auth: auth,
            firestore: firestore);

        expect(result.fold((l) => l, (r) => r), isA<Failure>());
        expect(result.fold((l) => l, (r) => r),
            const Failure(message: 'No current user present.'));
      },
    );
  });
}
