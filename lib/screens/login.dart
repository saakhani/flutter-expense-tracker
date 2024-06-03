import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:track_cash/screens/profile.dart';
import 'package:track_cash/screens/signup.dart';
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
  final auth = FirebaseAuth.instance;

  Future<User?> loginWithEmail(email, password) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void loginEmail(email, password) async {
    print("Attempting login");
    //login with google
    User? user = await loginWithEmail(email, password);
    if (user != null) {
      //to make sure that the widget is mounted when we switch contexts
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return ProfilePage(user: user);
      }), (route) => false);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to login')));
      print("There was an error");
    }
  }

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
                  "Welcome to TrackCash,",
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
                  decoration: textFieldTheme("Email", Icons.person, context),
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
                  onPressed: () {
                    loginEmail(
                        _usernameController.text, _passwordController.text);
                  },
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
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpScreen();
                          }), (route) => false);
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 0.0)),
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
