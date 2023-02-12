import 'package:bumblebee/screens/unauthenticated/auth-checker.dart';
import 'package:bumblebee/screens/unauthenticated/sign-up.dart';
import 'package:flutter/material.dart';

class BumbleBee extends StatelessWidget {
  const BumbleBee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BumbleBee",
      home: const AuthChecker(),
      routes: {
        '/signup': (context) => const SignUpPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
            primary: Colors.amber[600]!, secondary: Colors.blue),
      ),
    );
  }
}
