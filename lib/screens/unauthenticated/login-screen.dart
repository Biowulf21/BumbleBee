import 'package:bumblebee/controllers/auth-controller.dart';
import 'package:bumblebee/repositories/auth-repository.dart';
import 'package:bumblebee/repositories/input-validator-repository.dart';
import 'package:bumblebee/screens/reusable-widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../errors/failure.dart';
import '../login-state.dart';

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
    ref.listen<LoginState>(loginControllerProvider, ((previous, state) {
      if (state is LoginStateFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
        ));
      }
    }));

    return Scaffold(
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
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
                  try {
                    if (_loginFormKey.currentState!.validate()) {
                      final authProvider = ref
                          .read(loginControllerProvider.notifier)
                          .loginWithEmailAndPass(
                              _emailController.text, _passwordController.text);
                    }
                  } on AuthException catch (e) {
                    ScaffoldMessenger(
                        child: SnackBar(content: Text(e.errormessage)));
                  } on Failure catch (e) {
                    ScaffoldMessenger(
                        child: SnackBar(content: Text(e.message)));
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
