import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_cash/models/account_model.dart';

class AccountService {

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<List<AccountModel>> getAllAccounts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('transactions').get();
      List<QueryDocumentSnapshot<Object?>> docs = snapshot.docs;
      List<AccountModel> transactions =
          docs.map((doc) => AccountModel.fromQuerySnapshot(doc)).toList();
      return transactions;
    } catch (e) {
      print("Error $e");
      return [];
    }
  }

  Future<String> addAccount(String name, num init_amount,) async {
    try {
      DocumentReference doc = await _firestore.collection('accounts').add({
        "name": name,
        "amount": init_amount,
      });

      //returning the uuid
      return doc.id;
    } catch (e) {
      print("Error in adding child to firebase: $e");
      return "";
    }
  }
}
