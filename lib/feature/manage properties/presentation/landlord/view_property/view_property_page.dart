import 'package:bumblebee/core/models/property.dart';
import 'package:flutter/material.dart';

class ViewPropertyPage extends StatelessWidget {
  final Property property;
  const ViewPropertyPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [Text(property.name)],
      )),
    );
  }
}
