enum PropertyType { Studio, Single, Duplex }

enum Amenity { Electricity, Water, SwimmingPool, Elevator }

class Property {
  Property(
      {required this.name,
      required this.type,
      this.hasAdvance,
      this.rating,
      this.numberOfMonthsAdvance,
      this.id,
      this.costPerMonthsAdvance,
      this.hasDeposit,
      this.depositPrice,
      this.isFullyFurnished,
      this.amenities});
  final String name;
  final PropertyType type;
  String? id;
  double? rating;
  bool? hasAdvance = false;
  int? numberOfMonthsAdvance = 0;
  double? costPerMonthsAdvance = 0;
  bool? hasDeposit = false;
  double? depositPrice = 0;
  bool? isFullyFurnished = false;
  List<Amenity>? amenities;

  Property fromJson(Map<String, dynamic> json) {
    return Property(
      name: json['name'],
      type: PropertyType.values[json['type']],
      id: json['id'],
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
      'name': name,
      'type': type,
      'id': id,
      'rating': rating,
      'hasAdvanced': hasAdvance,
      'numberOfMonthsAdvanced': numberOfMonthsAdvance,
      'costPerMonthsAdvance': costPerMonthsAdvance,
      'hasDeposit': hasDeposit,
      'depositPrice': depositPrice,
      'isFullyFurnished': isFullyFurnished,
      'ameneties': amenities
    };
  }
}
