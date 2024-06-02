import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedTab = 0;

  List _pages = [
    Center(
      child: Text("Home"),
    ),
    Center(
      child: Text("About"),
    ),
    Center(
      child: Text("Products"),
    ),
    Center(
      child: Text("Contact"),
    ),
    Center(
      child: Text("Settings"),
    ),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) => _changeTab(index),
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.tertiary,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "Transactions"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),

      ],
    );
  }
}
