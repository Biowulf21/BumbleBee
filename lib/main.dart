import 'package:bumblebee/screens/authenticated/home.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const BumbleBee());
}

class BumbleBee extends StatelessWidget {
  const BumbleBee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BumbleBee",
      home: const HomeWidget(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
            primary: Colors.amber[600]!, secondary: Colors.blue),
      ),
    );
  }
}
