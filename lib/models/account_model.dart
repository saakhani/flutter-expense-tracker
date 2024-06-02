import 'package:cloud_firestore/cloud_firestore.dart';

class AccountModel {
  final String name;
  final double amount;

  AccountModel({required this.name, required this.amount});

    factory AccountModel.fromQuerySnapshot(QueryDocumentSnapshot doc) {
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    return AccountModel(
      name: json['name'] as String, 
      amount: ['amount'] as double,
    );
  }
}
