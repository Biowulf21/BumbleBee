import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:bumblebee/feature/manage%20properties/domain/usecases/create/create_property_usecase.dart';
import 'package:bumblebee/feature/manage%20properties/domain/usecases/update_property_usecase.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<UpdatePropertyUsecase>()])
void main() {
  final user = MockUser();
  final auth = MockFirebaseAuth(mockUser: user);
  final firestore = FakeFirebaseFirestore();
  test('UpdatePropertyUsecase returns Failure since user is unauthenticated',
      () async {
    final result = await UpdatePropertyUsecase().updateProperty(
        propertyID: 'testid', auth: auth, firestore: firestore, dataMap: {});

    expect(
        result.fold((failure) => failure, (successMessage) => successMessage),
        isA<Failure>());

    expect(
        result.fold((failure) => failure, (successMessage) => successMessage),
        const Failure(
            message: 'No user is logged in. Cannot create a new property.'));
  });
  group("Testing UpdatePropertyUsecase Failure cases", () {
    final user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    final MockFirebaseAuth auth = MockFirebaseAuth(mockUser: user);
    auth.signInWithEmailAndPassword(
        email: 'bob@somedomain.com', password: 'bruh');
    test(
        'UpdatePropertyUsecase returns Failure when no data map to update document is provided',
        () async {
      final newData = {'name': 'New Property Name'};

      final result = await UpdatePropertyUsecase().updateProperty(
          propertyID: 'someID', auth: auth, firestore: firestore);

      expect(result.fold((failure) => failure, (successMessage) => null),
          isA<Failure>());

      expect(result.fold((failure) => failure, (successMessage) => null),
          const Failure(message: 'Cannot update property. No data provided.'));
    });

    test(
        'UpdatePropertyUsecase returns Failure when no document is found to update',
        () async {
      final newData = Property(
          name: 'New Property',
          type: PropertyType.Single,
          address: "Test address");

      final result = await UpdatePropertyUsecase().updateProperty(
          propertyID: 'someID',
          auth: auth,
          firestore: firestore,
          propertyObj: newData);

      expect(result.fold((failure) => failure, (successMessage) => null),
          isA<Failure>());

      expect(result.fold((failure) => failure, (successMessage) => null),
          const Failure(message: 'Some requested document was not found.'));
    });
  });

  group('UpdatePropertyUseCase returns success test', () {
    final user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    final MockFirebaseAuth auth = MockFirebaseAuth(mockUser: user);
    auth.signInWithEmailAndPassword(
        email: 'bob@somedomain.com', password: 'bruh');

    final newData = Property(
        name: 'someID', type: PropertyType.Single, address: "Test address");

    test('UpdatePropertyUseCase returns success by using json', () async {
      const newName = 'newName';
      final oten = await CreatePropertyUseCase()
          .createProperty(
              name: 'oldID',
              type: PropertyType.Duplex,
              address: 'old Address',
              userRole: userRoles.Landlord,
              auth: auth,
              firestore: firestore)
          .then((value) async {
        value.fold((l) => print(l), (r) => print(r));
        final result = await firestore.collection('properties').get();

        final updateResult = await UpdatePropertyUsecase().updateProperty(
            propertyID: result.docs.first.id,
            auth: auth,
            firestore: firestore,
            dataMap: {'name': newName});

        expect(
            updateResult.fold((l) => null, (successMessage) => successMessage),
            "Successfully updated property.");

        final newResult = await firestore.collection('properties').get();

        expect(newResult.docs.first.data()['name'], newName);
      });
    });

    test('UpdatePropertyUseCase returns success by using property object',
        () async {
      const newName = 'newName';
      final oten = await CreatePropertyUseCase()
          .createProperty(
              name: 'oldID',
              type: PropertyType.Duplex,
              address: 'old Address',
              userRole: userRoles.Landlord,
              auth: auth,
              firestore: firestore)
          .then((value) async {
        value.fold((l) => print(l), (r) => print(r));
        final result = await firestore.collection('properties').get();

        final newProperty = Property(
            name: newName, type: PropertyType.Single, address: 'Test address');

        final updateResult = await UpdatePropertyUsecase().updateProperty(
            propertyID: result.docs.first.id,
            auth: auth,
            firestore: firestore,
            propertyObj: newProperty);

        expect(
            updateResult.fold((l) => null, (successMessage) => successMessage),
            "Successfully updated property.");

        final newResult = await firestore.collection('properties').get();

        expect(newResult.docs.first.data()['name'], newName);
        expect(newResult.docs.first.data()['type'].toString(),
            PropertyType.Single.toString());
      });
    });
  });
}
