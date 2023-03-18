import "package:bumblebee/core/models/property_converter.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  test('Property from Json works properly', () {
    final Map<String, dynamic> newProperty = {
      "name": 'test',
      "type": 'PropertyType.Single',
      "address": 'TestAddress',
      "ownerID": 'testID',
      "numberOfMonthsAdvance": null,
      "costPerMonthsAdvance": null,
      "hasDeposit": null,
      "depositPrice": null,
      "isFullyFurnished": null,
      "amenities": null,
    };

    final newPropertyFromConverter = PropertyConverter.fromJson(newProperty);

    expect(newPropertyFromConverter.name, 'test');
  });
}
