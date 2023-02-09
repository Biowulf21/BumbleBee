import 'package:bumblebee/screens/authenticated/home.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const BumbleBee());
}

class BumbleBee extends StatelessWidget {
  const BumbleBee({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "BumbleBee",
      home: HomeWidget(),
    );
  }
}
