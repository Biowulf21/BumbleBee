import 'dart:ffi';
import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/core/repositories/input_validator_repository.dart';
import 'package:bumblebee/core/wrappers/enum_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:parent_child_checkbox/parent_child_checkbox.dart';

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
  final TextEditingController costOfAdvanceController = TextEditingController();
  final TextEditingController numberOfMonthsAdvanceController =
      TextEditingController();
  final TextEditingController costOfDepositController = TextEditingController();
  // final TextEditingController bedroomCountController = TextEditingController();
  // final TextEditingController bedroomCountController = TextEditingController();
  //

  @override
  void dispose() {
    propertyNameController.dispose();
    addressController.dispose();
    typeController.dispose();
    typeController.dispose();
    bathroomCountController.dispose();
    bedroomCountController.dispose();
    costOfAdvanceController.dispose();
    costOfDepositController.dispose();
    super.dispose();
  }

  Future<void> saveProperty() async {}

  bool _hasAdvance = false;
  bool _hasDeposit = false;
  bool _isFullyFurnished = false;

  var currentPropertyType = PropertyType.Single;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Property"), actions: [
        IconButton(onPressed: saveProperty, icon: const Icon(Icons.save))
      ]),
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
                      label: Text('Address'),
                      hintText: '123 Monopoly Street, New York Avenue'),
                  controller: addressController,
                  validator: (value) =>
                      InputValidator.validateName(value, "first"),
                ),
                DropdownButton(
                  hint: const Text("Pick your role"),
                  value: currentPropertyType,
                  items: PropertyType.values.map((PropertyType role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(EnumConverter.convertEnumToShortString(role)),
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
                        value: _hasDeposit,
                        onChanged: (bool value) {
                          setState(() {
                            _hasDeposit = value;
                          });
                        }),
                  ],
                ),
                TextFormField(
                  enabled: _hasDeposit,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Deposit Price'), hintText: '1000'),
                  controller: costOfDepositController,
                  validator: (value) =>
                      InputValidator.validateName(value, "first"),
                ),
                Row(
                  children: [
                    const Text("Has Advance"),
                    Switch(
                        value: _hasAdvance,
                        onChanged: (bool value) {
                          setState(() {
                            _hasAdvance = value;
                          });
                        }),
                  ],
                ),
                TextFormField(
                  enabled: _hasAdvance,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Cost of Advance (Monthly)'),
                      hintText: '1000'),
                  controller: costOfAdvanceController,
                  validator: (value) =>
                      InputValidator.validateName(value, "first"),
                ),
                TextFormField(
                  enabled: _hasAdvance,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Number of Months Advance'), hintText: '2'),
                  controller: numberOfMonthsAdvanceController,
                  validator: (value) =>
                      InputValidator.validateName(value, "first"),
                ),
                Row(
                  children: [
                    const Text('Fully Furnished'),
                    Switch(
                        value: _isFullyFurnished,
                        onChanged: (bool value) {
                          setState(() {
                            _isFullyFurnished = value;
                          });
                        }),
                  ],
                ),
                ParentChildCheckbox(
                    parent: const Text("Amenities"),
                    children: Amenity.values.map((e) => Text(e.name)).toList()),
              ],
            ),
          )),
    );
  }
}
