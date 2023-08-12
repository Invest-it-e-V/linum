import 'package:flutter/material.dart';
import 'package:linum/features/currencies/models/currency.dart';

abstract class ICurrencySettingsService with ChangeNotifier {
  Currency getStandardCurrency();
  Future<void> setStandardCurrency(Currency currency);
}
