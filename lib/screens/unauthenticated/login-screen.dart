import 'package:bumblebee/repositories/input-validator-repository.dart';
import 'package:bumblebee/screens/reusable-widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth-provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
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
                controller: _emailController,
                validator: (value) => InputValidator.validateEmail(value),
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) => InputValidator.validatePassword(value),
              ),
              const SizedBox(
                height: 10,
              ),
              PrimaryButton(
                buttonText: "Log in",
                buttonCallback: () {
                  if (_loginFormKey.currentState!.validate()) {
                    final authProvider = ref
                        .watch(authRepositoryProvider)
                        .loginWithEmailandPassword(_emailController.text.trim(),
                            _passwordController.text.trim());
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SecondaryButton(
                buttonCallback: () {
                  Navigator.pushNamed(context, '/signup');
                },
                buttonText: "Sign up",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
