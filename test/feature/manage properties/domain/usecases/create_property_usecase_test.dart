import 'package:bumblebee/feature/manage%20properties/domain/usecases/create_property_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests about adding a property', () {
    test('Create property writes to a property document on firestore',
        () async {
      final result = await CreatePropertyUseCase.createProperty();
    });
  });
}
