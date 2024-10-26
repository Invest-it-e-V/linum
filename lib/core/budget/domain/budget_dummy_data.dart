import 'package:jiffy/jiffy.dart';
import 'package:linum/core/budget/domain/models/budget.dart';
import 'package:linum/core/budget/domain/models/budget_cap.dart';

final budgetDummyData = [
  Budget(
    name: "Essen",
    cap: BudgetCap(
      value: 200,
      type: CapType.amount,
    ),
    categories: [
      "food",
    ],
    start: Jiffy.now().subtract(months: 2).dateTime,
  ),
  Budget(
    name: "Traveling",
    cap: BudgetCap(
      value: 0.2,
      type: CapType.percentage,
    ),
    categories: [
      "freetime",
    ],
    start: Jiffy.now().subtract(months: 2).dateTime,
  ),
  Budget(
    name: "Lifestyle",
    cap: BudgetCap(
      value: 0.8,
      type: CapType.percentage,
    ),
    categories: [
      "lifestyle",
      "car",
    ],
    start: Jiffy.now().subtract(months: 2).dateTime,
  ),
];
