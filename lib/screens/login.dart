import 'package:flutter/material.dart';
import 'package:track_cash/widgets/google_signin_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  @override
  Widget build(BuildContext context){
    return const SafeArea(
      child: Scaffold(
        body: Center(child: GoogleSignInButton(),),
      ),
    );
  }
}