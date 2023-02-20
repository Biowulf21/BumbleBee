enum userRoles { Tenant, Landlord }

class User {
  final String firstName;

  final String middleName;

  final String lastName;

  final String contactNumber;

  final String email;

  final userRoles role;

  User(
      {required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.email,
      required this.contactNumber,
      required this.role});

  User.fromJson(Map<String, dynamic?> json)
      : this(
            email: json['email']! as String,
            contactNumber: json['contactNumber']! as String,
            role: json['role']! as userRoles,
            firstName: json['firstName']! as String,
            middleName: json['middleName'] as String,
            lastName: json['lastName'] as String);

  Map<String, Object?> toJson() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'contactNumber': contactNumber,
      'role': role.toString()
    };
  }
}
