import 'package:flutter/material.dart';
import 'package:linum/screens/budget_screen/budget_screen_tab.dart';
import 'package:linum/screens/budget_screen/widgets/main_budget_chart_slide.dart';

class RemainingTab extends StatelessWidget {
  const RemainingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const BudgetScreenTab(
      child: Column(
        children: [
          MainBudgetChartSlide()
        ],
      ),
    );
  }
}
