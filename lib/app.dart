import 'package:bumblebee/screens/unauthenticated/auth-checker.dart';
<<<<<<< HEAD
=======
import 'package:bumblebee/screens/unauthenticated/login-screen.dart';
import 'package:bumblebee/screens/unauthenticated/sign-up.dart';
>>>>>>> feature/home
import 'package:flutter/material.dart';

class BumbleBee extends StatelessWidget {
  const BumbleBee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BumbleBee",
      home: const AuthChecker(),
<<<<<<< HEAD
=======
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/login': (context) => const LoginPage(),
      },
>>>>>>> feature/home
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
            primary: Colors.amber[600]!, secondary: Colors.blue),
      ),
    );
  }
}
