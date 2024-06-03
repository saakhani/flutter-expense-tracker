import 'package:flutter/material.dart';
import 'package:track_cash/screens/details.dart';
import 'package:track_cash/screens/home.dart';

class NavBar extends StatefulWidget {
  final int pageIndex;
  const NavBar({Key? key, required index})
      : pageIndex = index,
        super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int _pageIndex = 0;


  _changeTab(int index) {
    if (index == 0) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }), (route) => false);
    } else if (index == 1) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return DetailsScreen();
      }), (route) => false);
    }
  }
  
  void initState() {
    _pageIndex = widget.pageIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _pageIndex,
      onTap: (index) => _changeTab(index),
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.tertiary,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: "Dashboard"),
        BottomNavigationBarItem(
            icon: Icon(Icons.history), label: "Transactions"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
