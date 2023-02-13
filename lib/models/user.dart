enum UserRoles { Tenant, Landlord }

class User {
  final String contactNumber;

  final String email;

  final UserRoles role;

  User({required this.email, required this.contactNumber, required this.role});
}
