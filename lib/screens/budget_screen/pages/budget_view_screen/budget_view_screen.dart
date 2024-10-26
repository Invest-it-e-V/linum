import 'package:flutter/material.dart';
import 'package:linum/common/widgets/loading_spinner.dart';
import 'package:linum/screens/budget_screen/budget_screen_viewmodel.dart';
import 'package:linum/screens/budget_screen/pages/budget_view_screen/widgets/main_budget_chart.dart';
import 'package:linum/screens/budget_screen/pages/budget_view_screen/widgets/sub_budget_tile.dart';
import 'package:provider/provider.dart';

class BudgetViewScreen extends StatelessWidget {
  const BudgetViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<BudgetScreenViewModel>();

    return FutureBuilder(
      future: Future.wait([
        viewModel.getBudgetViewData(DateTime.now()), // List<BudgetViewData>
        viewModel.getMainBudgetChartData(DateTime.now()), // MainBudgetViewData,
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: (snapshot.requireData[0] as List<BudgetViewData>).length+1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: MainBudgetChart(
                    data: (snapshot.requireData[1] as MainBudgetChartData),
                  ),
                );
              }
              return SubBudgetTile(
                budgetData: (snapshot.requireData[0]
                    as List<BudgetViewData>)[index-1],
              );
            },
          );
        }
        return const LoadingSpinner();
      },
    );
  }
}
