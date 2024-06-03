import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:track_cash/screens/details.dart';
import 'package:track_cash/screens/home.dart';
import 'package:track_cash/screens/profile.dart';

class NavBar extends StatefulWidget {
  final int pageIndex;
  final User pageUser;
  const NavBar({Key? key, required index, required User user})
      : pageIndex = index,
        pageUser = user,
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
        return HomeScreen(
          user: widget.pageUser,
        );
      }), (route) => false);
    } else if (index == 1) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return DetailsScreen(user: widget.pageUser);
      }), (route) => false);
    } else if (index == 2) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return ProfilePage(user: widget.pageUser);
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
