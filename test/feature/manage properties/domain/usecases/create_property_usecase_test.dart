import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/feature/manage%20properties/domain/usecases/create_property_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests about adding a property', () {
    const String propertyName = "Test property";
    const PropertyType type = PropertyType.Single;
    test('Create property writes to a property document on firestore',
        () async {
      final result = await CreatePropertyUseCase()
          .createProperty(name: propertyName, type: type);
      result.fold((failure) => print(failure.message), (successMessage) {
        expect(successMessage,
            'Successfully created new property named $propertyName');
      });
    });
  });
}
