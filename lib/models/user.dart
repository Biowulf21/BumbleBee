enum userRoles { Tenant, Landlord }

class User {
  final String contactNumber;

  final String email;

  final userRoles role;

  User({required this.email, required this.contactNumber, required this.role});

  User.fromJson(Map<String, dynamic?> json)
      : this(
            email: json['email']! as String,
            contactNumber: json['contactNumber']! as String,
            role: json['role']! as userRoles);

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'contactNumber': contactNumber,
      'role': role.toString()
    };
  }
}
