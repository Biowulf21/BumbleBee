import 'package:flutter/material.dart';

class PropertiesPage extends StatelessWidget {
  const PropertiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text("Something went wrong. Please try again later");
        } else {
          return ListView.builder(itemBuilder: (context, index) {
            return null;
          });
        }
      }),
    );
  }
}
