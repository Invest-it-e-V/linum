//  Settings Screen Standard Category - The selector for the standard categories
//
//  Author: aronzimmermann
//  Co-Author: SoTBurst, NightmindOfficial
//  Refactored: TheBlueBaron

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linum/common/components/action_lip/viewmodels/action_lip_viewmodel.dart';
import 'package:linum/common/enums/entry_type.dart';
import 'package:linum/common/widgets/category_list_tile.dart';
import 'package:linum/core/account/services/account_settings_service.dart';
import 'package:linum/core/categories/constants/standard_categories.dart';
import 'package:linum/core/categories/models/category.dart';
import 'package:linum/core/design/layout/enums/screen_key.dart';
import 'package:linum/core/design/layout/widgets/screen_skeleton.dart';
import 'package:linum/screens/settings_screen/widget/standard_category/category_list_view.dart';
import 'package:provider/provider.dart';

class StandardCategorySelector extends StatefulWidget {
  const StandardCategorySelector({super.key});

  @override
  State<StandardCategorySelector> createState() => _StandardCategorySelectorState();
}

class _StandardCategorySelectorState extends State<StandardCategorySelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.read<ActionLipViewModel>().setActionLip(
              screenKey: ScreenKey.settings,
              actionLipStatus: ActionLipVisibility.onviewport,
              actionLipTitle:
                  tr('action_lip.standard-category.income.label-title'),
              actionLipBody: CategoryListView(
                categories: standardCategories.values
                    .where((category) => category.entryType == EntryType.income)
                    .toList(),
                settingsKey: "StandardCategoryIncome",
              ),
            );
          },
          child: Selector<AccountSettingsService, Category?>(
            selector: (_, settings) => settings.getIncomeEntryCategory(),
            builder: (context, category, _) {
              return CategoryListTile(
                labelTitle:
                    tr('settings_screen.standard-income-selector.label-title'),
                category: category,
                trailingIcon: Icons.north_east,
                trailingIconColor: Colors.green,
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<ActionLipViewModel>().setActionLip(
              screenKey: ScreenKey.settings,
              actionLipStatus: ActionLipVisibility.onviewport,
              actionLipTitle:
                  tr('action_lip.standard-category.expenses.label-title'),
              actionLipBody: CategoryListView(
                categories: standardCategories.values
                    .where((category) => category.entryType == EntryType.expense)
                    .toList(),
                settingsKey: "StandardCategoryExpense",
              ),
            );
          },
          child: Selector<AccountSettingsService, Category?>(
            selector: (_, settings) => settings.getExpenseEntryCategory(),
            builder: (context, category, _) {
              return CategoryListTile(
                labelTitle:
                    tr('settings_screen.standard-expense-selector.label-title'),
                category: category,
                trailingIcon: Icons.south_east,
                trailingIconColor: Colors.red,
              );
            },
          ),
        ),
      ],
    );
  }
}