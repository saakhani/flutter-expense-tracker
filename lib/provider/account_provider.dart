import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_cash/models/account_model.dart';
import 'package:track_cash/services/account_services.dart';

part 'account_provider.g.dart';

@riverpod
Future<List<AccountModel>> getAllAccounts(GetAllAccountsRef ref) {
  return AccountService().getAllAccounts();
}

