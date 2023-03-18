import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/feature/manage%20properties/presentation/landlord/view_property/view_property_page.dart';
import 'package:flutter/material.dart';

class PropertyTile extends StatelessWidget {
  final Property property;

  const PropertyTile({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(property.name),
      subtitle: Text(property.address),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewPropertyPage(
                      property: property,
                    )));
      },
    );
  }
}
