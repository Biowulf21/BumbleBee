import 'package:bumblebee/repositories/auth-repository.dart';
import 'package:bumblebee/screens/reusable-widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text('Verify email here...'),
          TextButton(
              onPressed: () {
                AuthRepository(FirebaseAuth.instance)
                    .sendEmailVerificationMessage();
              },
              child: const Text("Resend email verification link")),
          SecondaryButton(
              buttonText: "Done Verifying",
              buttonCallback: () {
                FirebaseAuth.instance.currentUser?.reload();
                bool? isEmailVerified =
                    FirebaseAuth.instance.currentUser?.emailVerified;
                print(isEmailVerified);
                if (isEmailVerified == true) {
                  Navigator.pushNamed(context, '/');
                }
              }),
          PrimaryButton(
              buttonText: "Log out",
              buttonCallback: () {
                AuthRepository(FirebaseAuth.instance).logout();
              })
        ],
      ),
    );
  }
}
