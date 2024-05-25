import 'package:flutter/material.dart';
import 'package:track_cash/screens/home.dart';

void main() {
  runApp(const CashTrackApp());
}

class CashTrackApp extends StatelessWidget {
  const CashTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrackCash',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
