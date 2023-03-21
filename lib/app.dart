import 'package:bumblebee/feature/authentication/presentation/auth_checker.dart';
import 'package:bumblebee/feature/authentication/presentation/unauthenticated/forgot_password.dart';
import 'package:bumblebee/feature/authentication/presentation/unauthenticated/login_screen.dart';
import 'package:bumblebee/feature/manage%20properties/presentation/landlord/new_property/new_property_screen.dart';
import 'package:flutter/material.dart';
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
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/new-property': (context) => const NewPropertyScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
            primary: Colors.amber[600]!, secondary: Colors.black),
      ),
    );
  }
}
