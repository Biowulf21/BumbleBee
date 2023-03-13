import 'package:bumblebee/core/models/property.dart';

class PropertyConverter {
  Property? propertyToJson;

  PropertyConverter({this.propertyToJson});

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
      'name': propertyToJson?.name,
      'type': propertyToJson?.type.toString(),
      'address': propertyToJson?.address,
      'ownerID': propertyToJson?.ownerID,
      'rating': propertyToJson?.rating,
      'hasAdvanced': propertyToJson?.hasAdvance,
      'numberOfMonthsAdvanced': propertyToJson?.numberOfMonthsAdvance,
      'costPerMonthsAdvance': propertyToJson?.costPerMonthsAdvance,
      'hasDeposit': propertyToJson?.hasDeposit,
      'depositPrice': propertyToJson?.depositPrice,
      'isFullyFurnished': propertyToJson?.isFullyFurnished,
      'ameneties': propertyToJson?.amenities
    };
  }
}
