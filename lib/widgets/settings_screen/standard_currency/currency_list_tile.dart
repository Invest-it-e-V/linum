import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linum/models/currency.dart';

class CurrencyListTile extends StatelessWidget {
  const CurrencyListTile({
    super.key,
    required this.currency,
  });
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        tr(currency.label),
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: const Icon(
        Icons.arrow_forward,
      ),
      leading: Icon(
        currency.icon ?? Icons.error,
      ),
    );
  }
}