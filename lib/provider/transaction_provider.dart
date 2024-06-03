import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_cash/models/transaction_model.dart';
import 'package:track_cash/services/transaction_service.dart';

part 'transaction_provider.g.dart';

@riverpod
Future<List<TransactionModel>> getAllTransactions(GetAllTransactionsRef ref) {
  return TransactionService().getAllTransactions();
}

@riverpod
Future<List<TransactionModel>> getTenTransactions(GetTenTransactionsRef ref) {
  return TransactionService().getTenTransactions();
}
