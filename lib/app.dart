import 'package:bumblebee/screens/unauthenticated/auth-checker.dart';
import 'package:bumblebee/screens/unauthenticated/forgot-password.dart';
import 'package:bumblebee/screens/unauthenticated/login-screen.dart';
import 'package:bumblebee/screens/unauthenticated/signup-auth-checker.dart';
import 'package:flutter/material.dart';

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
        '/forgot-password': (context) => ForgotPasswordPage()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
            primary: Colors.amber[600]!, secondary: Colors.blue),
      ),
    );
  }
}
