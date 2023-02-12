import 'package:bumblebee/repositories/input-validator-repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _signupKey = GlobalKey();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _organizationNameController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final userRoles = ['Tenant', 'Landlord'];
  var currentUserRole = 'Tenant';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _signupKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _firstNameController,
                  validator: (value) =>
                      InputValidator.validateName(value, "first"),
                ),
                TextFormField(
                  controller: _middleNameController,
                  validator: (value) =>
                      InputValidator.validateName(value, "middle"),
                ),
                TextFormField(
                  controller: _lastNameController,
                  validator: (value) =>
                      InputValidator.validateName(value, "last"),
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (value) => InputValidator.validateEmail(value),
                ),
                DropdownButton(
                  hint: const Text("Pick your role"),
                  value: currentUserRole,
                  items: userRoles.map((String role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      currentUserRole = value!;
                      print(currentUserRole);
                    });
                  },
                ),
                InternationalPhoneNumberInput(
                  countries: const ['PH'],
                  validator: (value) =>
                      InputValidator.validatePhilippinePhoneNumber(value),
                  onInputChanged: (newValue) {
                    // print(newValue.phoneNumber);
                  },
                )
              ],
            )),
      ),
    );
  }
}
