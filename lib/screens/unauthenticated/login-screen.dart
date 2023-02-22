import 'package:bumblebee/controllers/login-state-controller.dart';
import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/feature/authentication/domain/repositories/auth-repository.dart';
import 'package:bumblebee/core/repositories/input-validator-repository.dart';
import 'package:bumblebee/screens/reusable-widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../login-state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordIsVisible = true;
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _loginFormKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(label: Text('Email')),
                  controller: _emailController,
                  validator: (value) => InputValidator.validateEmail(value),
                ),
                TextFormField(
                  obscureText: _passwordIsVisible,
                  decoration: InputDecoration(
                      label: const Text('Password'),
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
                PrimaryButton(
                  buttonText: "Log in",
                  buttonCallback: () {
                    try {
                      if (_loginFormKey.currentState!.validate()) {
                        final authProvider = ref
                            .read(loginControllerProvider.notifier)
                            .loginWithEmailAndPass(_emailController.text,
                                _passwordController.text);
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
                TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/forgot-password'),
                    child: const Text('Forgot password'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
