import 'package:flutter/material.dart';
import 'package:track_cash/screens/home.dart';
import 'package:track_cash/utilities/theme.dart';

void main() {
  runApp(const CashTrackApp());
}

class CashTrackApp extends StatelessWidget {
  const CashTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrackCash',
      theme: trackCashTheme(),
      home: const HomeScreen(),
    );
  }
}

