import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:track_cash/screens/home.dart';
import 'package:track_cash/screens/new_transaction.dart';
import 'package:track_cash/services/transaction_service.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for each TextFormField
  final _amountController = TextEditingController();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();

  String _selectedCategory = 'Food';
  // Account? _selectedAccount;
  bool _isIncome = false;

  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _amountController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // Fetch accounts from Firestore
  // Future<List<Account>> _fetchAccounts() async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('accounts')
  //       .get();
  //   return snapshot.docs.map((doc) => Account(
  //     name: doc['name'],
  //     amount: doc['amount'],
  //   )).toList();
  // }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
            controller: _amountController,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 32),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an amount';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Date',
              border: OutlineInputBorder(),
            ),
            controller: _dateController,
            readOnly: true,
            onTap: () => _selectDate(context),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a date';
              }
              return null;
            },
          ),
          SizedBox(
            height: 16,
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
            value: _selectedCategory,
            items: ['Food', 'Transport', 'Utilities', 'Other'].map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a category';
              }
              return null;
            },
          ),
          SizedBox(
            height: 16,
          ),
          // FutureBuilder<List<Account>>(
          //   future: _fetchAccounts(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return CircularProgressIndicator();
          //     }
          //     if (snapshot.hasError) {
          //       return Text('Error fetching accounts');
          //     }
          //     return DropdownButtonFormField<Account>(
          //       decoration: InputDecoration(
          //         labelText: 'Account',
          //         border: OutlineInputBorder(),
          //       ),
          //       value: _selectedAccount,
          //       items: snapshot.data?.map((account) {
          //         return DropdownMenuItem<Account>(
          //           value: account,
          //           child: Text(account.name),
          //         );
          //       }).toList(),
          //       onChanged: (value) {
          //         setState(() {
          //           _selectedAccount = value;
          //         });
          //       },
          //       validator: (value) {
          //         if (value == null) {
          //           return 'Please select an account';
          //         }
          //         return null;
          //       },
          //     );
          //   },
          // ),
          SizedBox(
            height: 16,
          ),
          SwitchListTile(
            title: Text('Income'),
            value: _isIncome,
            onChanged: (bool value) {
              setState(() {
                _isIncome = value;
              });
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
                  String success = await TransactionService().AddTransaction(
                        _nameController.text,
                        num.tryParse(_amountController.text) ?? 0,
                        _selectedCategory,
                        _selectedDate,
                        _isIncome,
                        ""
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
              "Submit",
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
