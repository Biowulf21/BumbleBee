import 'package:bumblebee/controllers/login-state-controller.dart';
import 'package:bumblebee/core/wrappers/firebase_singleton.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:bumblebee/core/repositories/input_validator_repository.dart';
import 'package:bumblebee/repositories/user-repository.dart';
import 'package:bumblebee/screens/login_state.dart';
import 'package:bumblebee/screens/reusable-widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _signupKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _organizationNameController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  var currentUserRole = userRoles.Tenant;
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordIsVisible = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _organizationNameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginControllerProvider, ((previous, state) {
      if (state is LoginStateFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
        ));
      }
    }));

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
                    label: Text('Email'),
                    hintText: 'email@example.com',
                  ),
                  controller: _emailController,
                  validator: (value) => InputValidator.validateEmail(value),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: _passwordIsVisible,
                  decoration: InputDecoration(
                      label: const Text('Password'),
                      hintText: 'Samplepassword123!',
                      suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordIsVisible = !_passwordIsVisible;
                            });
                          },
                          icon: _passwordIsVisible
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off))),
                  controller: _passwordController,
                  validator: (value) => InputValidator.validatePassword(value),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(label: Text('Confirm password')),
                  controller: _confirmPasswordController,
                  validator: (value) => InputValidator.validateConfirmPassword(
                      value, _passwordController.text),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  hint: const Text("Pick your role"),
                  value: currentUserRole,
                  items: userRoles.values.map((userRoles role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role.toString()),
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
                PrimaryButton(
                    buttonText: "Submit",
                    buttonCallback: () async {
                      if (_signupKey.currentState!.validate()) {
                        final userObject = User(
                            firstName: _firstNameController.text,
                            middleName: _middleNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            role: currentUserRole,
                            contactNumber: _numberController.text);

                       final result =  await UserRepository(
                                firestoreInstance:
                                    FirebaseSingleton().getFirestore,
                                auth: FirebaseSingleton().getAuth)
                            .createUserFromObject(
                                userObject: userObject,
                                password: _passwordController.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Please make sure all fields are correct.')));
                      }
                    }),
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
