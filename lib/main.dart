import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:track_cash/screens/login.dart';
import 'package:track_cash/screens/signup.dart';
import 'package:track_cash/utilities/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CashTrackApp());
}

class CashTrackApp extends StatelessWidget {
  const CashTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrackCash',
      theme: trackCashTheme(),
      home: LoginScreen(),
    );
  }
}

