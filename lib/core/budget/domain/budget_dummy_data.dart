import 'package:jiffy/jiffy.dart';
import 'package:linum/core/budget/domain/models/budget.dart';
import 'package:linum/core/budget/domain/models/budget_cap.dart';

final budgetDummyData = [
  Budget(
    name: "Traveling",
    cap: BudgetCap(
      value: 0.1,
      type: CapType.percentage,
    ),
    categories: [
      "food",
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
  Budget(
    name: "Essen & Trinken",
    cap: BudgetCap(
      value: 0.1,
      type: CapType.percentage,
    ),
    categories: [
      "lifestyle",
      "food",
    ],
    start: Jiffy.now().subtract(months: 2).dateTime,
  )
];
