import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:track_cash/screens/login.dart';
import 'package:track_cash/widgets/nav_bar.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${user.displayName}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                IconButton(
                icon: Icon(Icons.logout),
                color: Theme.of(context).colorScheme.primary,
                iconSize: 32,
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }), (route) => false);
                },
              ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              ' ${user.email}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(index: 2, user: user),
    );
  }
}
