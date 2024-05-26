import 'package:flutter/material.dart';
import 'package:track_cash/widgets/google_signin_button.dart';
import 'package:track_cash/widgets/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
  
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Create Account,"),
              const Text("Sign up to get started!"),
              SignUpForm(),

            ],
          ),
        ),
      ),
    );
  }
}
