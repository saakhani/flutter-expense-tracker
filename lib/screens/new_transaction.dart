import 'package:flutter/material.dart';
import 'package:track_cash/widgets/transaction_form.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
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
              SizedBox(height: 128,),
              Text("Add new transaction", style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 16,),
              TransactionForm(),
            ],
          ),
        ),
      ),
    );
  }
}
