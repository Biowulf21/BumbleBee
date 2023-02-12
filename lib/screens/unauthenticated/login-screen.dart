import 'package:bumblebee/screens/authenticated/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('loading');
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print('error in logging in');
            return const Text("Error encountered");
          } else if (snapshot.hasData) {
            print('logged in');
            return const HomeWidget();
          } else {
            print('not logged in');
            return const Loginpage();
          }
        },
      ),
    );
  }
}

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
