import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_cash/models/account_model.dart';

class TransactionModel {
  final String name;
  final String category;
  final DateTime date;
  final bool income;
  final double amount;
  final String account;

  TransactionModel({
    required this.name,
    required this.category,
    required this.date,
    required this.income,
    required this.amount,
    required this.account,
  });

  factory TransactionModel.fromQuerySnapshot(QueryDocumentSnapshot doc) {
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    return TransactionModel(
        name: json['name'] as String,
        category: json['category'] as String,
        date: (json['date'] as Timestamp).toDate(),
        income: json['income'] as bool,
        amount: (json['amount'] as num).toDouble(),
        account: (json['account'] as String));
  }
}
