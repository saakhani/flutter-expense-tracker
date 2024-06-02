import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_cash/models/transaction_model.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<List<TransactionModel>> getAllTransactions() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('transactions').get();
      List<QueryDocumentSnapshot<Object?>> docs = snapshot.docs;
      List<TransactionModel> transactions =
          docs.map((doc) => TransactionModel.fromQuerySnapshot(doc)).toList();
      return transactions;
    } catch (e) {
      print("Error $e");
      return [];
    }
  }


}