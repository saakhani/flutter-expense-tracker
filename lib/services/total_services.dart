import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_cash/models/account_model.dart';

class TotalService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<double> getTotal() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('total').get();
      List<QueryDocumentSnapshot<Object?>> docs = snapshot.docs;
      print(docs);
      return (docs[0]['total']).toDouble();
    } catch (e) {
      print("Error $e");
      return -1;
    }
  }

  void updateTotal(num amount) async {
    var currTotal = _firestore.collection('total').doc('0');

    currTotal.update(
      {"total": FieldValue.increment(amount)},
    );
  }
}
