import 'package:bumblebee/providers/auth-provider.dart';
import 'package:bumblebee/repositories/input-validator-repository.dart';
import 'package:bumblebee/screens/reusable-widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuthException, FirebaseAuth;

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authInstance = ref.read(firebaseAuthInstanceProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Builder(builder: (context) {
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text('Email Address')),
                validator: (value) => InputValidator.validateEmail(value),
                controller: _emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              PrimaryButton(
                  buttonText: "Submit",
                  buttonCallback: () async {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailController.text);
                      _showMyDialog(context);
                    } on FirebaseAuthException catch (e) {
                      print(e.code);
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("User not found. Please try again.")));
                      } else if (e.code == 'invalid-email') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Invalid email address provided. Please try again')));
                      }
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.message!)));
                    }
                  }),
            ],
          ),
        ));
      }),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Password reset link sent!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Please check your email to reset your password.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
