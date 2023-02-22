import 'package:flutter/material.dart';
import 'feature/authentication/presentation/auth_checker.dart';
import 'feature/authentication/presentation/forgot_password.dart';
import 'feature/authentication/presentation/login_screen.dart';
import 'feature/authentication/presentation/signup_auth_checker.dart';

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
