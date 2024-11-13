import 'package:flutter/material.dart';
import 'package:linum/screens/budget_screen/budget_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class MainBudgetChartSlide extends StatelessWidget {
  const MainBudgetChartSlide({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BudgetScreenViewModel>();

    /*return const MonthSlide(
      child: MainBudgetChart(
        maxBudget: 1000,
        currentExpenses: 500.0, // -viewModel.calculations.sumCosts.toDouble(),
      ),
    );
  */
    return const Placeholder();
  }
}
