import 'dart:ffi';

import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/core/repositories/input_validator_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewPropertyScreen extends StatefulWidget {
  const NewPropertyScreen({super.key});

  @override
  State<NewPropertyScreen> createState() => _NewPropertyScreenState();
}

class _NewPropertyScreenState extends State<NewPropertyScreen> {
  final _newPropertyKey = GlobalKey<FormState>();
  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController bathroomCountController = TextEditingController();
  final TextEditingController bedroomCountController = TextEditingController();

  bool hasAdvance = false;
  bool hasDeposit = false;

  var currentPropertyType = PropertyType.Single;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
          key: _newPropertyKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text('Property Name'),
                      hintText: 'My New Property'),
                  controller: propertyNameController,
                  validator: (value) =>
                      InputValidator.validateName(value, "first"),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text('Property'),
                      hintText: '123 Monopoly Street, New York Avenue'),
                  controller: addressController,
                  validator: (value) =>
                      InputValidator.validateName(value, "first"),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text('First Name'), hintText: 'John'),
                  controller: typeController,
                  validator: (value) =>
                      InputValidator.validateName(value, "first"),
                ),
                DropdownButton(
                  hint: const Text("Pick your role"),
                  value: currentPropertyType,
                  items: PropertyType.values.map((PropertyType role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      currentPropertyType = value!;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Number of Bathrooms'), hintText: '2'),
                  controller: bathroomCountController,
                  validator: (value) =>
                      InputValidator.validateName(value, "first"),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Number of Bedrooms'), hintText: '2'),
                  controller: bedroomCountController,
                  validator: (value) =>
                      InputValidator.validateName(value, "first"),
                ),
                Row(
                  children: [
                    const Text("Has Deposit"),
                    Switch(
                        value: hasDeposit,
                        onChanged: (bool value) {
                          setState(() {
                            hasDeposit = value;
                          });
                        }),
                  ],
                ),
                Row(
                  children: [
                    const Text("Has Advance"),
                    Switch(
                        value: hasAdvance,
                        onChanged: (bool value) {
                          setState(() {
                            hasAdvance = value;
                          });
                        }),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
