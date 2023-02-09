import 'package:bumblebee/screens/authenticated/profile_page.dart';
import 'package:bumblebee/screens/authenticated/properties_page.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  // ignore: prefer_final_fields
  int _selectedIndex = 0;

  void changeSelectedItemIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _bottomNavBarChildren = <Widget>[
    HomePageLayout(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BumbleBee"),
        backgroundColor: Colors.amber[700],
      ),
      body: _bottomNavBarChildren.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _selectedIndex,
        onTap: changeSelectedItemIndex,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomePageLayout extends StatelessWidget {
  const HomePageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Home'),
    );
  }
}
