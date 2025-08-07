import 'dart:convert';

import '../../core/utils/shared_preferences_helper.dart';
import '../datasources/mock_data.dart';
import '../models/transaction_model.dart';

class PointsRepository {
  Future<int> getUserPoints() async {
    return SharedPreferencesHelper.userPoints;
  }

  Future<List<TransactionModel>> getTransactions() async {
    try {
      final transactionsJson = SharedPreferencesHelper.getTransactions();

      if (transactionsJson.isEmpty) {
        final sampleTransactions = await MockData.getTransactions();
        await saveTransactions(sampleTransactions);
        return sampleTransactions;
      }

      return transactionsJson
          .map((json) => TransactionModel.fromJson(jsonDecode(json)))
          .toList()
          .reversed
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      final transactions = await getTransactions();
      transactions.insert(0, transaction);
      await saveTransactions(transactions);

      // Update points
      final currentPoints = SharedPreferencesHelper.userPoints;
      await SharedPreferencesHelper.setUserPoints(currentPoints + transaction.points);
    } catch (e) {
      throw Exception('Failed to add transaction: $e');
    }
  }

  Future<void> saveTransactions(List<TransactionModel> transactions) async {
    final transactionsJson = transactions
        .map((transaction) => jsonEncode(transaction.toJson()))
        .toList();

    await SharedPreferencesHelper.instance.remove(SharedPreferencesHelper.keyTransactions);
    await SharedPreferencesHelper.instance.setStringList(
      SharedPreferencesHelper.keyTransactions,
      transactionsJson,
    );
  }
}
