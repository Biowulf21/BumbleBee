import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/core/wrappers/enum_converter.dart';

class PropertyConverter {
  PropertyConverter();

  static Property fromJson(Map<String, dynamic> json) {
    return Property(
      name: json['name'],
      type: PropertyType.values
          .byName(EnumConverter.convertStringToShortString(json['type'])),
      address: json['address'],
      ownerID: json['ownerID'],
      rating: json['rating'],
      hasAdvance: json['hasAdvance'],
      numberOfMonthsAdvance: json['numberOfMonthsAdvance'],
      costPerMonthsAdvance: json['costPerMonthsAdvance'],
      hasDeposit: json['hasDeposit'],
      depositPrice: json['depositPrice'],
      isFullyFurnished: json['isFullyFurnished'],
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
