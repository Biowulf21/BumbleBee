import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/core/wrappers/firebase_singleton.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:bumblebee/feature/manage%20properties/domain/usecases/read/get_properties_usecase.dart';
import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({super.key});

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  Future<Either<Failure, List<Property>>> getProperties() async {
    final query = await GetAllPropertiesUseCase().getAllPropertiesByID(
        auth: FirebaseSingleton().getAuth,
        firestore: FirebaseSingleton().getFirestore,
        userRole: userRoles.Landlord);

    return query;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getProperties(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.fold((failure) {
              return Text(failure.message);
            }, (properties) {
              return properties.isEmpty
                  ? const Text("No properties")
                  : ListView.builder(
                      itemCount: properties.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(properties[index].name),
                          subtitle: Text(properties[index].address),
                        );
                      },
                    );
            });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
