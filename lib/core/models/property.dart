enum PropertyType { Studio, Single, Duplex }

enum Amenity { Electricity, Water, SwimmingPool, Elevator }

class Property {
  Property({
    required this.name,
    required this.type,
    required this.address,
    this.hasDeposit,
    this.ownerID,
    this.depositPrice,
    this.hasAdvance,
    this.costPerMonthsAdvance,
    this.numberOfMonthsAdvance,
    this.isFullyFurnished,
    this.amenities,
    this.rating,
  });
  final String name;
  final PropertyType type;
  final String address;
  String? ownerID;
  double? rating;
  bool? hasAdvance = false;
  int? numberOfMonthsAdvance = 0;
  double? costPerMonthsAdvance = 0;
  bool? hasDeposit = false;
  double? depositPrice = 0;
  bool? isFullyFurnished = false;
  List<Amenity>? amenities;
}
