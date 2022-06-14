//  Settings Screen Standard Category - The selector for the standard categories
//
//  Author: aronzimmermann
//  Co-Author: SoTBurst, NightmindOfficial
//  Refactored: TheBlueBaron

import 'package:flutter/material.dart';
import 'package:linum/constants/settings_enums.dart';
import 'package:linum/constants/standard_expense_categories.dart';
import 'package:linum/constants/standard_income_categories.dart';
import 'package:linum/providers/account_settings_provider.dart';
import 'package:linum/providers/action_lip_status_provider.dart';
import 'package:linum/utilities/backend/local_app_localizations.dart';
import 'package:linum/utilities/frontend/size_guide.dart';
import 'package:linum/widgets/screen_skeleton/screen_skeleton.dart';
import 'package:linum/widgets/settings_screen/standard_category/standard_category_expenses_list_tile.dart';
import 'package:linum/widgets/settings_screen/standard_category/standard_category_income_list_tile.dart';
import 'package:provider/provider.dart';

class StandardCategory extends StatefulWidget {
  const StandardCategory({Key? key}) : super(key: key);

  @override
  State<StandardCategory> createState() => _StandardCategoryState();
}

class _StandardCategoryState extends State<StandardCategory> {
  @override
  Widget build(BuildContext context) {
    final AccountSettingsProvider accountSettingsProvider =
        Provider.of<AccountSettingsProvider>(context);
    final ActionLipStatusProvider actionLipStatusProvider =
        Provider.of<ActionLipStatusProvider>(context);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            actionLipStatusProvider.setActionLip(
              providerKey: ProviderKey.settings,
              actionLipStatus: ActionLipStatus.onviewport,
              actionLipTitle: AppLocalizations.of(context)!.translate(
                'action_lip/standard-category/income/label-title',
              ),
              actionLipBody: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: proportionateScreenHeightFraction(
                            ScreenFraction.twofifths,
                          ),
                          child: _incomeListViewBuilder(
                            accountSettingsProvider,
                            actionLipStatusProvider,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          child: StandardCategoryIncomeListTile(
            accountSettingsProvider: accountSettingsProvider,
          ),
        ),
        GestureDetector(
          onTap: () {
            actionLipStatusProvider.setActionLip(
              providerKey: ProviderKey.settings,
              actionLipStatus: ActionLipStatus.onviewport,
              actionLipTitle: AppLocalizations.of(context)!.translate(
                'action_lip/standard-category/expenses/label-title',
              ),
              actionLipBody: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: proportionateScreenHeightFraction(
                              ScreenFraction.twofifths),
                          child: _expensesListViewBuilder(
                            accountSettingsProvider,
                            actionLipStatusProvider,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          child: StandardCategoryExpensesListTile(
            accountSettingsProvider: accountSettingsProvider,
          ),
        ),
      ],
    );
  }

  //ListView.builder für Standard Kategorien
  ListView _incomeListViewBuilder(
    AccountSettingsProvider accountSettingsProvider,
    ActionLipStatusProvider actionLipStatusProvider,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: StandardCategoryIncome.values.length,
      itemBuilder: (BuildContext context, int indexBuilder) {
        return ListTile(
          leading: Icon(
            standardCategoryIncomes[StandardCategoryIncome.values[indexBuilder]]
                ?.icon,
          ),
          title: Text(
            AppLocalizations.of(context)!.translate(
              standardCategoryIncomes[
                          StandardCategoryIncome.values[indexBuilder]]
                      ?.label ??
                  "Category",
            ),
          ),
          selected:
              "StandardCategoryIncome.${accountSettingsProvider.settings["StandardCategoryIncome"] as String? ?? "None"}" ==
                  StandardCategoryIncome.values[indexBuilder].toString(),
          onTap: () {
            final List<String> stringArr = StandardCategoryIncome
                .values[indexBuilder]
                .toString()
                .split(".");
            accountSettingsProvider.updateSettings({
              stringArr[0]: stringArr[1],
            });
            actionLipStatusProvider.setActionLipStatus(
              providerKey: ProviderKey.settings,
            );
          },
        );
      },
    );
  }

  ListView _expensesListViewBuilder(
    AccountSettingsProvider accountSettingsProvider,
    ActionLipStatusProvider actionLipStatusProvider,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: StandardCategoryExpense.values.length,
      itemBuilder: (BuildContext context, int indexBuilder) {
        return ListTile(
          //leading: Icon(widget.categories[index].icon),
          leading: Icon(
            standardCategoryExpenses[
                    StandardCategoryExpense.values[indexBuilder]]
                ?.icon,
          ),
          title: Text(
            AppLocalizations.of(context)!.translate(
              standardCategoryExpenses[
                          StandardCategoryExpense.values[indexBuilder]]
                      ?.label ??
                  "Category",
            ),
          ),
          selected:
              "StandardCategoryExpense.${accountSettingsProvider.settings["StandardCategoryExpense"] as String? ?? "None"}" ==
                  StandardCategoryExpense.values[indexBuilder].toString(),
          onTap: () {
            final List<String> stringArr = StandardCategoryExpense
                .values[indexBuilder]
                .toString()
                .split(".");
            accountSettingsProvider.updateSettings({
              stringArr[0]: stringArr[1],
            });
            actionLipStatusProvider.setActionLipStatus(
              providerKey: ProviderKey.settings,
            );
          },
        );
      },
    );
  }
}