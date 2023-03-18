import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/core/wrappers/firebase_singleton.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:bumblebee/feature/manage%20properties/domain/usecases/create/create_property_usecase.dart';
import 'package:bumblebee/providers/auth_provider.dart';
import 'package:bumblebee/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:bumblebee/screens/reusable-widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:bumblebee/screens/profile_page.dart';
import 'package:bumblebee/feature/manage%20properties/presentation/landlord/properties_page.dart';

class LandlordHomeLayout extends ConsumerStatefulWidget {
  const LandlordHomeLayout({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LandlordHomeLayoutState();
}

class _LandlordHomeLayoutState extends ConsumerState<LandlordHomeLayout> {
  @override
  void initState() {
    // TODO: implement initState
    final isUserEmailVerified =
        AuthRepository(FirebaseAuth.instance).getVerificationStatus();
    isUserEmailVerified.fold((l) => l, (r) {
      _isVerified = r;
    });
  }

  @override
  bool? _isVerified;
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    if (_isVerified == false) {
      return Column(
        children: [
          const Text('Please verify your email address to proceed.'),
          PrimaryButton(
              buttonText: "Done Verifying", buttonCallback: () async {})
        ],
      );
    }
    return Container(
      child: Text(_isVerified.toString()),
    );
  }
}

class LandlordHomePage extends ConsumerStatefulWidget {
  const LandlordHomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LandlordHomeWidgetState();
}

class _LandlordHomeWidgetState extends ConsumerState<LandlordHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _bottomNavBarChildren = <Widget>[
    LandlordHomeLayout(),
    PropertiesPage(),
    ProfilePage(),
  ];

  static const List<BottomNavigationBarItem> bottomNavItems =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: "Home",
    ),
    BottomNavigationBarItem(icon: Icon(Icons.cases), label: "Properties"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  static const List<IconData> _secondaryMenuIcons = <IconData>[
    Icons.house_sharp,
    Icons.search
  ];

  static const List<String> _secondaryMenuLabels = <String>[
    "Add New Property",
    "Search"
  ];

  void changeSelectedItemIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("BumbleBee"),
        backgroundColor: Colors.amber[700],
      ),
      body: _bottomNavBarChildren.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _selectedIndex,
        onTap: changeSelectedItemIndex,
      ),
      floatingActionButton: SpeedDialFabWidget(
          primaryBackgroundColor: Theme.of(context).colorScheme.primary,
          primaryIconExpand: Icons.add,
          secondaryIconsList: _secondaryMenuIcons,
          secondaryIconsOnPress: [
            () => {
                  CreatePropertyUseCase().createProperty(
                      name: 'Test',
                      type: PropertyType.Single,
                      address: 'test address',
                      userRole: userRoles.Landlord,
                      auth: FirebaseSingleton().getAuth,
                      firestore: FirebaseSingleton().getFirestore)
                },
            () => {}
          ],
          secondaryIconsText: _secondaryMenuLabels),
    );
  }
}
