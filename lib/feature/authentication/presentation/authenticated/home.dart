import 'package:bumblebee/core/wrappers/firebase_singleton.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:bumblebee/feature/manage%20properties/presentation/landlord/landlord_home.dart';
import 'package:bumblebee/repositories/user-repository.dart';
import 'package:bumblebee/feature/authentication/presentation/authenticated/tenant/tenant-home.dart';
import 'package:bumblebee/feature/authentication/presentation/authenticated/verify_email_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late userRoles _userRole;
  bool _userIsVerified = false;
  @override
  void initState() {
    super.initState();
    getCurrentRole();
  }

  Future<User?> getCurrentRole() async {
    final currentUser = await UserRepository(
      firestoreInstance: FirebaseSingleton().getFirestore,
      auth: FirebaseSingleton().getAuth,
    ).getUserInfo(userID: FirebaseSingleton().getAuth.currentUser!.uid);

    return currentUser.fold(
      (l) {
        return null;
      },
      (user) {
        if (FirebaseSingleton().getAuth.currentUser == null) {
          return null;
        }
        _userRole = user!.role;
        _userIsVerified =
            FirebaseSingleton().getAuth.currentUser!.emailVerified;
        return user;
      },
    );
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
              } else if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Text('oten');
              }
            }),
      ),
    );
  }
}
