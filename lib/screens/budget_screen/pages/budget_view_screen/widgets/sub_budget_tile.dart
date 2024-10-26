import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linum/core/categories/core/presentation/category_service.dart';
import 'package:linum/core/stats/domain/models/expense_statistic.dart';
import 'package:linum/features/currencies/core/utils/currency_formatter.dart';
import 'package:linum/features/currencies/settings/presentation/currency_settings_service.dart';
import 'package:provider/provider.dart';

typedef CategoryViewData = ({String name, ExpenseStatistics expenses});

class BudgetViewData {
  final String name;
  final double currentExpenses;
  final double upcomingExpenses;
  final double cap;
  final List<CategoryViewData> categories;

  BudgetViewData({
    required this.currentExpenses,
    required this.upcomingExpenses,
    required this.name,
    required this.cap,
    required this.categories,
  });

  double get totalExpenses => upcomingExpenses + currentExpenses;
}

class SubBudgetTile extends StatefulWidget {
  final BudgetViewData budgetData;
  const SubBudgetTile({super.key, required this.budgetData});

  @override
  State<SubBudgetTile> createState() => _SubBudgetTileState();
}

class _SubBudgetTileState extends State<SubBudgetTile> {
  bool isOpen = false;
  double turns = 0.0;
  List<CategoryViewData> categories = [];

  final animationDuration = 150;
  late final stepDuration =
      animationDuration ~/ widget.budgetData.categories.length;

  Future<void> _showCategories() async {
    for (final cat in widget.budgetData.categories) {
      setState(() {
        categories.add(cat);
        // categories = [...categories, cat];
      });
      await Future.delayed(Duration(milliseconds: stepDuration), () {});
    }
  }

  Future<void> _removeCategories() async {
    for (final _ in widget.budgetData.categories) {
      setState(() {
        categories.removeLast();
      });
      await Future.delayed(Duration(milliseconds: stepDuration), () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter = CurrencyFormatter(
      context.locale,
      symbol: context
          .watch<ICurrencySettingsService>()
          .getStandardCurrency()
          .symbol,
    );

    final remaining = widget.budgetData.cap + widget.budgetData.totalExpenses;
    final categoryCap = widget.budgetData.cap;
    final categoryService = context.read<ICategoryService>();
    final value = -widget.budgetData.totalExpenses /
        (widget.budgetData.cap == 0 ? 1 : widget.budgetData.cap);

    var color = theme.colorScheme.primary;
    Color? colorExpenses;
    String statusExpenses;

    if (value >= 1) {
      color = theme.colorScheme.error;
    } else if (value >= 0.75) {
      color = Colors.orange;
    } else if (value >= 0.5) {
      color = Colors.yellow;
    }

    if (-widget.budgetData.totalExpenses == 0) {
      print(widget.budgetData.totalExpenses);
      colorExpenses = theme.colorScheme.secondary;
      statusExpenses = 'remaining';
    } else if (-widget.budgetData.totalExpenses >= categoryCap) {
      colorExpenses = theme.colorScheme.error;
      statusExpenses = 'exceeded';
    } else {
      colorExpenses = theme.colorScheme.primary;
      statusExpenses = 'remaining';
    }

    return Card.outlined(
      shape: colorExpenses == theme.colorScheme.error
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                width: 1.5,
                color: colorExpenses,
              ),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.budgetData.name,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
                AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 150),
                  child: IconButton(
                    onPressed: () {
                      if (isOpen) {
                        _removeCategories();
                      } else {
                        _showCategories();
                      }

                      setState(() {
                        isOpen = !isOpen;
                        if (turns == 0.5) {
                          turns = .0;
                        } else {
                          turns = .5;
                        }
                      });
                    },
                    icon: const Icon(Icons.expand_more),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.black12,
                color: color,
                value: value,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${formatter.format(remaining)} $statusExpenses",
                  style: theme.textTheme.labelMedium
                      ?.copyWith(color: colorExpenses),
                ),
                Text(
                  formatter.format(categoryCap),
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
            if (isOpen) const Divider(),
            AnimatedSize(
              alignment: Alignment.topLeft,
              duration: const Duration(milliseconds: 150),
              child: isOpen
                  ? Column(
                      children: categories.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                categoryService
                                        .getCategoryByKey(item.name)
                                        ?.label
                                        .tr() ??
                                    item.name,
                              ),
                              Text(formatter.format(item.expenses.current +
                                  item.expenses.upcoming)),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Convert Widgets to Stack
Cut upper Stack Border, but leave the

 */
