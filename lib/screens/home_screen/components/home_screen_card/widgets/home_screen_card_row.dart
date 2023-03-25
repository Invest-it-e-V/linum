//  Home Screen Card Bottom Row - Bottom Part of the Home Screen displaying additional Metrics
//
//  Author: NightmindOfficial
//  Co-Author: n/a
//  (Refactored by damattl)

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linum/common/components/screen_card/widgets/home_screen_card_avatar.dart';
import 'package:linum/common/utils/currency_formatter.dart';
import 'package:linum/core/account/services/account_settings_service.dart';
import 'package:linum/core/design/layout/utils/layout_helpers.dart';
import 'package:linum/features/currencies/models/currency.dart';
import 'package:linum/screens/home_screen/components/home_screen_card/models/home_screen_card_data.dart';
import 'package:provider/provider.dart';

// ignore_for_file: deprecated_member_use
//TODO DEPRECATED

class HomeScreenCardRow extends StatelessWidget {
  final Stream<HomeScreenCardData>? data;
  final HomeScreenCardAvatar upwardArrow;
  final HomeScreenCardAvatar downwardArrow;

  const HomeScreenCardRow({
    super.key,
    required this.data,
    required this.upwardArrow,
    required this.downwardArrow,
  });

  Expanded _buildIncomeExpensesInfo(
    BuildContext context, {
    bool isIncome = false,
  }) {
    return Expanded(
      flex: 10,
      child: Row(
        mainAxisAlignment:
            isIncome ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isIncome) ...[
            upwardArrow,
            SizedBox(width: context.proportionateScreenWidth(10))
          ],
          Column(
            crossAxisAlignment:
                isIncome ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(
                tr(
                  isIncome
                      ? 'home_screen_card.label-income'
                      : 'home_screen_card.label-expenses',
                ),
                style: Theme.of(context)
                    .textTheme
                    .overline!
                    .copyWith(fontSize: 12),
              ),
              StreamBuilder<HomeScreenCardData>(
                stream: data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      "--",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    );
                  }
                  return Selector<AccountSettingsService, Currency>(
                    selector: (_, settings) => settings.getStandardCurrency() ,
                    builder: (context, standardCurrency, _) {
                      return Text(
                        CurrencyFormatter(
                          context.locale,
                          symbol: standardCurrency.symbol,
                        ).format(
                          isIncome
                              ? snapshot.data?.mtdIncome ?? 0
                              : snapshot.data?.mtdExpenses ?? 0,
                        ),
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          if (!isIncome) ...[
            SizedBox(width: context.proportionateScreenWidth(10)),
            downwardArrow
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIncomeExpensesInfo(context, isIncome: true),
        const Expanded(
          flex: 3,
          child: FittedBox(
            fit: BoxFit.scaleDown,
          ),
        ),
        _buildIncomeExpensesInfo(context)
      ],
    );
  }
}