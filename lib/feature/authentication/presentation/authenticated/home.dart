import 'package:bumblebee/core/wrappers/firebase_singleton.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:bumblebee/repositories/user-repository.dart';
import 'package:bumblebee/feature/authentication/presentation/authenticated/landlord/landlord-home.dart';
import 'package:bumblebee/feature/authentication/presentation/authenticated/tenant/tenant-home.dart';
import 'package:bumblebee/feature/authentication/presentation/authenticated/verify_email_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../domain/repositories/auth_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late userRoles _userRole;
  bool? _userIsVerified = false;
  // TODO: implement initState
  Future<User?> getCurrentRole() async {
    final currentUser = await UserRepository(
            firestoreInstance: FirebaseSingleton().getFirestore,
            auth: FirebaseSingleton().getAuth)
        .getUserInfo(userID: FirebaseAuth.instance.currentUser!.uid);
    final userData = currentUser;
    _userRole = userData?.role ?? userRoles.Tenant;

    _userIsVerified = FirebaseAuth.instance.currentUser?.emailVerified;
    final oten = FirebaseAuth.instance.currentUser;
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
                if (_userIsVerified == false) {
                  return const VerifyEmailPage();
                }
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
