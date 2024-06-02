import 'package:flutter/material.dart';
import 'package:track_cash/screens/home.dart';
import 'package:track_cash/services/account_services.dart';
import 'package:track_cash/utilities/theme.dart';

class AccountForm extends StatefulWidget {
  const AccountForm({super.key});

  @override
  State<AccountForm> createState() => AccountFormState();
}

class AccountFormState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for each TextFormField
  final _nameController = TextEditingController();
  final _initialAmountController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _nameController.dispose();
    _initialAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration:
                textFieldTheme("Account name", Icons.wallet_rounded, context),
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the account name';
              }
              return null;
            },
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration:
                textFieldTheme("Initial amount", Icons.attach_money, context),
            controller: _initialAmountController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an initial amount';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          SizedBox(
            height: 32,
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            onPressed: () async {
              try {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data: ')));

                  String success = await AccountService().addAccount(
                        _nameController.text,
                        num.tryParse(_initialAmountController.text) ?? 0,
                      ) ??
                      "";

                  if (success.isNotEmpty) {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }), (route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Error '),
                      backgroundColor: Colors.redAccent,
                    ));
                  }

                  // Here you can also send the data to a server or save it in a database.
                }
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Error ')));
              }
            },
            child: Text(
              "Add account",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
