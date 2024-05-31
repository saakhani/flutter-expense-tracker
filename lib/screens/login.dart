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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Welcome,",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Sign in to continue!",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  TextField(
                    controller: _usernameController,
                    style: Theme.of(context).textTheme.bodyMedium,
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
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                                  SizedBox(
                    height: 8,
                  ),
                  const GoogleSignInButton(),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(onPressed: () {}, child: Text("Sign up"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
