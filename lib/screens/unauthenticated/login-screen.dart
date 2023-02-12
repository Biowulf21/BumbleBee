import 'package:bumblebee/repositories/input-validator-repository.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                validator: (value) => InputValidator.validateEmail(value),
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) => InputValidator.validatePassword(value),
              ),
              TextButton(
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      print('otenhehe');
                    }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
