import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_cash/models/transaction_model.dart';
import 'package:track_cash/screens/new_transaction.dart';
import 'package:track_cash/services/total_services.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('transactions').orderBy("date", descending: true).get();
      List<QueryDocumentSnapshot<Object?>> docs = snapshot.docs;
      List<TransactionModel> transactions =
          docs.map((doc) => TransactionModel.fromQuerySnapshot(doc)).toList();
      return transactions;
    } catch (e) {
      print("Error $e");
      return [];
    }
  }

    Future<List<TransactionModel>> getTenTransactions() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('transactions').orderBy("date", descending: true).limit(10).get();
      List<QueryDocumentSnapshot<Object?>> docs = snapshot.docs;
      List<TransactionModel> transactions =
          docs.map((doc) => TransactionModel.fromQuerySnapshot(doc)).toList();
      return transactions;
    } catch (e) {
      print("Error $e");
      return [];
    }
  }

  Future<String> AddTransaction(String name, num amount, String category,
      DateTime date, bool income, String account) async {
    try {
      DocumentReference doc = await _firestore.collection('transactions').add({
        "name": name,
        "amount": amount,
        "category": category,
        "date": Timestamp.fromDate(date),
        "account": account,
        "income": income,
      });

      if (income) {
        TotalService().updateTotal(amount);
      } else {
        TotalService().updateTotal(-1 * amount);
      }

      //returning the uuid
      return doc.id;
    } catch (e) {
      print("Error in adding child to firebase: $e");
      return "";
    }
  }
}
