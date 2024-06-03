import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_cash/models/account_model.dart';
import 'package:track_cash/services/account_services.dart';
import 'package:track_cash/services/total_services.dart';

part 'total_provider.g.dart';

@riverpod
Future<double> getTotal(GetTotalRef ref) {
  return TotalService().getTotal();
}

