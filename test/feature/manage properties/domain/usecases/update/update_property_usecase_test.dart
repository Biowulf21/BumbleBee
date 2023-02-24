import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/feature/manage%20properties/domain/usecases/update_property_usecase.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<UpdatePropertyUsecase>()])
void main() {
  group("Testing UpdatePropertyUsecase", () {
    final user = MockUser();
    final auth = MockFirebaseAuth(mockUser: user);
    final firestore = FakeFirebaseFirestore();
    test('UpdatePropertyUsecase returns Failure since user is unauthenticated',
        () async {
      final result = await UpdatePropertyUsecase().updateProperty(
          propertyID: 'testid', auth: auth, firestore: firestore);

      expect(
          result.fold((failure) => failure, (successMessage) => successMessage),
          isA<Failure>());

      expect(
          result.fold((failure) => failure, (successMessage) => successMessage),
          const Failure(
              message: 'No user is logged in. Cannot create a new property.'));
    });
  });
}
