import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:track_cash/widgets/account_form.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key, required this.user});
  final User user;

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 128,
              ),
              Text("Add new account",
                  style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(
                height: 16,
              ),
              AccountForm(user: widget.user,),
            ],
          ),
        ),
      ),
    );
  }
}
