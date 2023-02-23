class Contract {
  Contract(this.contractStart, this.contractEnd, this.id, this.ownerID,
      this.renterID,
      [this.isExpired, this.expiryDate]);
  DateTime contractStart;
  DateTime contractEnd;
  String id;
  String ownerID;
  String renterID;
  int? numberOfMonths;
  bool? isExpired;
  bool? expiryDate;

  Map<String, dynamic> toJson(
      DateTime contractStart,
      DateTime contractEnd,
      String id,
      String ownerID,
      String renterID,
      int? numberOfMonths,
      bool? isExpired,
      bool? expiryDate) {
    return {
      'contractStart': contractStart,
      'contractEnd': contractEnd,
      'id': id,
      'ownerID': ownerID,
      'renterID': renterID,
      'numberOfMonths': numberOfMonths,
      'isExpired': isExpired,
      'expiryDate': expiryDate
    };
  }
}
