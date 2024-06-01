import 'package:flutter/material.dart';
import 'package:track_cash/utilities/theme.dart';
import 'package:track_cash/widgets/google_signin_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textThemeCurr = Theme.of(context).textTheme;
    ColorScheme colorSchemeCurr = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Welcome,",
                  style: textThemeCurr.headlineLarge,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Sign in to continue!",
                  style: textThemeCurr.headlineSmall,
                ),
                SizedBox(
                  height: 32,
                ),
                TextField(
                  controller: _usernameController,
                  style: textThemeCurr.bodyMedium,
                  decoration: textFieldTheme("Username", Icons.person, context),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: textFieldTheme("Password", Icons.lock, context),
                  obscureText: true,
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ))),
                  child: Text(
                    "Login",
                    style: textThemeCurr.bodyLarge
                        ?.copyWith(color: colorSchemeCurr.onPrimary),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GoogleSignInButton(),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: textThemeCurr.bodyMedium,
                    ),
                    TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 0.0)),
                        child: Text(
                          "Sign up",
                          style: textThemeCurr.bodyMedium
                              ?.copyWith(color: colorSchemeCurr.primary),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
