import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linum/core/design/layout/enums/screen_fraction_enum.dart';
import 'package:linum/core/design/layout/utils/layout_helpers.dart';
import 'package:linum/features/currencies/core/constants/standard_currencies.dart';
import 'package:linum/features/currencies/core/presentation/widgets/currency_list_tile.dart';
import 'package:linum/screens/enter_screen/presentation/view_models/enter_screen_form_view_model.dart';
import 'package:linum/screens/enter_screen/presentation/widgets/buttons/linum_close_button.dart';
import 'package:provider/provider.dart';

class CurrencyListView extends StatelessWidget {
  final currencies = standardCurrencies.values.toList();

  CurrencyListView({super.key});


  @override
  Widget build(BuildContext context) {
    final formViewModel = context.read<EnterScreenFormViewModel>();

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: context.proportionateScreenHeightFraction(ScreenFraction.onetenth),
              ),
              shrinkWrap: true,
              itemCount: currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final currency = currencies[index];
                return CurrencyListTile(
                  currency: currency,
                  selected:
                    currency.name == formViewModel.data.options.currency?.name,
                  onTap: () {
                    formViewModel.data = formViewModel.data.copyWithOptions(
                      currency: currency,
                    );
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
          const LinumCloseButton(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          const SizedBox(height: 24,),
        ],
      ),
    );
  }
}
