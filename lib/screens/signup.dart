import 'package:flutter/material.dart';
import 'package:track_cash/widgets/google_signin_button.dart';
import 'package:track_cash/widgets/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textThemeCurr = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Create Account,",
                  style: textThemeCurr.headlineLarge,
                ),
                SizedBox(height: 8,),
                Text("Sign up to get started!",
                    style: textThemeCurr.headlineSmall),
               SizedBox(height: 32,),
                SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
