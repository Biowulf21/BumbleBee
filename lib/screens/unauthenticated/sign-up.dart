import 'package:bumblebee/repositories/input-validator-repository.dart';
import 'package:bumblebee/reusable-widgets/buttons.dart';
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
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _signupKey,
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text('First Name'), hintText: 'John'),
                  controller: _firstNameController,
                  validator: (value) =>
                      InputValidator.validateName(value, "first"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text('Middle Name (optional)'),
                      hintText: 'Saunders'),
                  controller: _middleNameController,
                  validator: (value) =>
                      InputValidator.validateName(value, "middle"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text('Last Name'), hintText: 'Smith'),
                  controller: _lastNameController,
                  validator: (value) =>
                      InputValidator.validateName(value, "last"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text('Email'), hintText: 'email@example.com'),
                  controller: _emailController,
                  validator: (value) => InputValidator.validateEmail(value),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text('Password'), hintText: 'Samplepassword123!'),
                  controller: _passwordController,
                  validator: (value) => InputValidator.validatePassword(value),
                ),
                const SizedBox(
                  height: 10,
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
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                InternationalPhoneNumberInput(
                  textFieldController: _numberController,
                  countries: const ['PH'],
                  validator: (value) =>
                      InputValidator.validatePhilippinePhoneNumber(value),
                  onInputChanged: (newValue) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                PrimaryButton(buttonText: "Submit", buttonCallback: () {}),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    const SizedBox(
                      width: 2,
                    ),
                    TextButton(
                      child: const Text('Login'),
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
