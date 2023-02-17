import 'package:bumblebee/screens/authenticated/profile-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TenantHomePage extends ConsumerStatefulWidget {
  const TenantHomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TenantHomePageState();
}

class _TenantHomePageState extends ConsumerState<TenantHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _bottomNavBarChildren = <Widget>[
    TenantHomePageLayout(),
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
    );
  }
}

class TenantHomePageLayout extends StatelessWidget {
  const TenantHomePageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
