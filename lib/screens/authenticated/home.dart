import 'package:bumblebee/models/user.dart';
import 'package:bumblebee/repositories/user-repository.dart';
import 'package:bumblebee/screens/authenticated/landlord/landlord-home.dart';
import 'package:bumblebee/screens/authenticated/tenant/tenant-home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../repositories/auth-repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late userRoles _userRole;
  // TODO: implement initState
  Future<User?> getCurrentRole() async {
    final currentUser =
        await UserRepository(firestoreInstance: FirebaseFirestore.instance)
            .getUserInfo(userID: FirebaseAuth.instance.currentUser!.uid);
    final userData = currentUser;
    _userRole = userData?.role ?? userRoles.Tenant;
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getCurrentRole(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (_userRole == userRoles.Landlord) {
                  return const LandlordHomePage();
                }

                return const TenantHomePage();
              } else if (snapshot.hasError) {
                return const Text('otin error');
              } else {
                return Column(
                  children: [
                    const CircularProgressIndicator(),
                    TextButton(
                        onPressed: () {
                          AuthRepository(FirebaseAuth.instance).logout();
                        },
                        child: const Text('logout'))
                  ],
                );
              }
            }),
      ),
    );
  }
}
