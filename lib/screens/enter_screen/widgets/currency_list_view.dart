import 'package:flutter/material.dart';
import 'package:linum/common/widgets/currency_list_tile.dart';
import 'package:linum/core/design/layout/enums/screen_fraction_enum.dart';
import 'package:linum/core/design/layout/utils/layout_helpers.dart';
import 'package:linum/features/currencies/constants/standard_currencies.dart';
import 'package:linum/screens/enter_screen/viewmodels/enter_screen_view_model.dart';
import 'package:provider/provider.dart';

class CurrencyListView extends StatelessWidget {
  final currencies = standardCurrencies.values.toList();

  CurrencyListView({super.key});


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EnterScreenViewModel>(context, listen: false);

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          bottom: context.proportionateScreenHeightFraction(ScreenFraction.onefifth),
        ),
        shrinkWrap: true,
        itemCount: currencies.length,
        itemBuilder: (BuildContext context, int index) {
          final currency = currencies[index];
          return CurrencyListTile(
            currency: currency,
            selected:
              currency.name == viewModel.data.currency?.name,
            onTap: () {
              viewModel.update(viewModel.data.copyWith(currency: currency));
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}
