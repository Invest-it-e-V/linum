import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:linum/constants/standard_categories.dart';
import 'package:linum/constants/standard_currencies.dart';
import 'package:linum/constants/standard_repeat_configs.dart';
import 'package:linum/enter_screen/enums/repeat_interval.dart';
import 'package:linum/enter_screen/view_models/enter_screen_view_model_data.dart';
import 'package:linum/models/category.dart';
import 'package:linum/models/currency.dart';
import 'package:linum/models/repeat_configuration.dart';
import 'package:linum/models/serial_transaction.dart';
import 'package:linum/models/transaction.dart';

typedef OnSaveCallback = void Function({
  Transaction? transaction,
  SerialTransaction? serialTransaction,
});
// TODO: Add SerialTransaction
void _onSaveDefault({
  Transaction? transaction,
  SerialTransaction? serialTransaction,
}) {}

class EnterScreenViewModel extends ChangeNotifier {
  late String? _transactionId;
  late OnSaveCallback _onSave;

  late EnterScreenViewModelData _data;

  late num defaultAmount;
  late String defaultName;
  late Currency defaultCurrency;
  late Category? defaultCategory;
  late String defaultDate;
  late RepeatConfiguration defaultRepeatConfiguration;

  EnterScreenViewModel._(
    BuildContext context, {
    OnSaveCallback onSave = _onSaveDefault,
    Transaction? transaction,
    SerialTransaction? serialTransaction, // TODO: Implement those
  }) {
    _transactionId = transaction?.id;
    _onSave = onSave;

    defaultName = "";
    defaultAmount = 0;
    defaultCurrency = standardCurrencies["EUR"]!;
    defaultDate = DateTime.now().toIso8601String();
    defaultCategory = null;
    defaultRepeatConfiguration = repeatConfigurations[RepeatInterval.daily]!;

    _data = EnterScreenViewModelData(
      withExistingData: transaction != null || serialTransaction != null,
      name: transaction?.name,
      amount: transaction?.amount,
      currency: standardCurrencies[transaction?.currency],
      date: transaction?.time.toDate().toIso8601String(),
      category: standardCategories[transaction?.category],
    );
    // No _selectedRepeatInfo for transactions
  }

  factory EnterScreenViewModel.empty(BuildContext context) {
    return EnterScreenViewModel._(context);
  }

  factory EnterScreenViewModel.fromTransaction(
    BuildContext context,
    Transaction transaction,
  ) {
    return EnterScreenViewModel._(
      context,
      transaction: transaction,
    );
  }

  factory EnterScreenViewModel.fromSerialTransaction(
      BuildContext context,
      SerialTransaction serialTransaction,
  ) {
    return EnterScreenViewModel._(
      context,
      serialTransaction: serialTransaction,
    );
  }

  EnterScreenViewModelData get data => _data;

  void update(EnterScreenViewModelData data, {bool notify = false}) {
    _data = data;
    if (notify) {
      notifyListeners();
    }
  }

  void save() {
    if (data.repeatConfiguration != null
        && data.repeatConfiguration?.interval != RepeatInterval.none) {
      final serialTransaction = SerialTransaction(
          amount: data.amount ?? defaultAmount,
          category: data.category?.id ?? defaultCategory?.id,
          currency: data.currency?.name ?? defaultCurrency.name,
          name: data.name ?? defaultName,
          initialTime: firestore.Timestamp.fromDate(DateTime.parse(data.date ?? defaultDate)),
          repeatDuration: data.repeatConfiguration!.duration!,
          // This is not null because only RepeatInterval.none holds a null duration value
      );
      _onSave(serialTransaction: serialTransaction);
      return;
    }

    final transaction = Transaction(
      id: _transactionId,
      amount: data.amount ?? defaultAmount,
      currency: data.currency?.name ?? defaultCurrency.name,
      name: data.name ?? defaultName,
      time: firestore.Timestamp.fromDate(DateTime.parse(data.date ?? defaultDate)),
      category: data.category?.id ?? defaultCategory?.id,
    );

    _onSave(transaction: transaction);
  }
}
