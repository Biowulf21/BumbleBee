import 'package:flutter/material.dart';

class PropertyTile extends StatelessWidget {
  final String propertyName;
  final String propertyAddress;
  final bool? hasTenant;

  const PropertyTile(
      {super.key,
      required this.propertyName,
      required this.propertyAddress,
      this.hasTenant});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(propertyName),
      subtitle: Text(propertyAddress),
    );
  }
}
