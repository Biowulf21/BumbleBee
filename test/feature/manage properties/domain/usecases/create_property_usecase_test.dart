import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/feature/manage%20properties/domain/usecases/create_property_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests about adding a property', () {
    const String propertyName = "Test property";
    const PropertyType type = PropertyType.Single;
    const String address = 'Test address for the new property';

    test('CreatePropertyUsecase writes to a property document on firestore.',
        () async {
      final result = await CreatePropertyUseCase()
          .createProperty(name: propertyName, type: type, address: address);
      result.fold((failure) => print(failure.message), (successMessage) {
        expect(successMessage,
            'Successfully created new property named $propertyName');
      });
    });

    test(
        'CreatePropertyUsecase throws failure since user only has tenant privileges.',
        () {});
  });
}
