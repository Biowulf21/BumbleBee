import 'package:bumblebee/feature/authentication/presentation/unauthenticated/login-screen.dart';
import 'package:bumblebee/feature/authentication/presentation/unauthenticated/signup-auth-checker.dart';
import 'package:flutter/material.dart';

import 'feature/authentication/presentation/auth-checker.dart';
import 'feature/authentication/presentation/forgot-password.dart';

class BumbleBee extends StatelessWidget {
  const BumbleBee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BumbleBee",
      routes: {
        '/': (context) => const AuthChecker(),
        '/signup': (context) => const SignUpAuthChecker(),
        '/login': (context) => const LoginPage(),
        '/forgot-password': (context) => const ForgotPasswordPage()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
            primary: Colors.amber[600]!, secondary: Colors.black),
      ),
    );
  }
}
