import 'package:bumblebee/core/models/property.dart';

class PropertyConverter {
  PropertyConverter();

  static Property fromJson(Map<String, dynamic> json) {
    return Property(
      name: json['name'],
      type: PropertyType.values.byName(json['type']),
      address: json['address'],
      ownerID: json['ownerID'],
      rating: json['rating'],
      hasAdvance: json['hasAdvance'] ?? false,
      numberOfMonthsAdvance: json['numberOfMonthsAdvance'] ?? 0,
      costPerMonthsAdvance: json['costPerMonthsAdvance'] ?? 0,
      hasDeposit: json['hasDeposit'] ?? false,
      depositPrice: json['depositPrice'] ?? 0,
      isFullyFurnished: json['isFullyFurnished'] ?? false,
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((amenityJson) => Amenity.values[amenityJson])
          .toList(),
    );
  }

  Map<String, dynamic> toJson(Property propertyObj) {
    return {
      'name': propertyObj.name,
      'type': propertyObj.type.toString(),
      'address': propertyObj.address,
      'ownerID': propertyObj.ownerID,
      'rating': propertyObj.rating,
      'hasAdvanced': propertyObj.hasAdvance,
      'numberOfMonthsAdvanced': propertyObj.numberOfMonthsAdvance,
      'costPerMonthsAdvance': propertyObj.costPerMonthsAdvance,
      'hasDeposit': propertyObj.hasDeposit,
      'depositPrice': propertyObj.depositPrice,
      'isFullyFurnished': propertyObj.isFullyFurnished,
      'ameneties': propertyObj.amenities
    };
  }
}
