import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CurrencyFormatter {
  final String symbol;
  late final NumberFormat _formatter;
  CurrencyFormatter(Locale locale, {this.symbol = "€"}) {
    if (amountBeforeSymbol()) {
      _formatter = NumberFormat.currency(
        locale: locale.toString(),
        symbol: symbol,
        customPattern: "#0.00",
      );
    } else {
      _formatter = NumberFormat.currency(
          locale: locale.toString(),
          symbol: symbol,
          customPattern: "#0.00",
      );
    }
  }


  String format(num value) {
    final numberPart = _formatter.format(value);
    if (amountBeforeSymbol()) {
      return "$numberPart$symbol";
    } else {
      return "$symbol$numberPart";
    }



  }

  bool amountBeforeSymbol() {
    if (symbol == "€") {
      return true;
    } else { // $, £
      return false;
    }
  }

}
