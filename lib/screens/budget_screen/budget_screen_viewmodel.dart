import 'package:flutter/cupertino.dart';
import 'package:linum/core/balance/presentation/algorithm_service.dart';
import 'package:linum/core/budget/domain/models/budget.dart';
import 'package:linum/core/budget/domain/models/budget_cap.dart';
import 'package:linum/core/budget/domain/models/main_budget.dart';
import 'package:linum/core/budget/presentation/budget_service.dart';
import 'package:linum/core/stats/domain/models/income_statistic.dart';
import 'package:linum/core/stats/presentation/statistics_service.dart';
import 'package:linum/screens/budget_screen/budget_routes.dart';
import 'package:linum/screens/budget_screen/pages/budget_view_screen/widgets/sub_budget_tile.dart';
import 'package:linum/screens/budget_screen/pages/budget_view_screen/widgets/main_budget_chart.dart';

class BudgetScreenViewModel extends ChangeNotifier {
  // final StatisticalCalculations calculations;
  final IBudgetService _service;
  final IStatisticsService _statService;
  final AlgorithmService _algService;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BudgetScreenViewModel({
    required IBudgetService budgetService,
    required IStatisticsService statService,
    required AlgorithmService algorithmService,
  })  : _service = budgetService,
        _statService = statService,
        _algService = algorithmService;

  Future<T?> goTo<T>(String route, {bool replace = false}) async {
    if (replace) {
      return navigatorKey.currentState?.pushReplacementNamed(route);
    }
    return navigatorKey.currentState?.pushNamed(route);
  }

  String getInitialRoute() {
    return BudgetRoutes.view;
  }

  Future<MainBudgetChartData> getMainBudgetChartData(DateTime date) async {
    final futures = await Future.wait([
      _statService.getStatisticalCalculations().then((c) => c.sumCosts),
      _statService.getSerialIncomeForMonth(date),
      _service.getMainBudgetForDate(date),
    ]);

    final sumCosts = futures[0]! as num;
    final incomeStats = futures[1]! as IncomeStatistics;
    final mainBudget = futures[2] as MainBudget?;

    if (mainBudget == null || mainBudget.amount == null) {
      return (
        maxBudget: (incomeStats.upcoming + incomeStats.current).toDouble(),
        currentExpenses: -sumCosts.toDouble(),
        isGenerated: true,
      );
    }
    return (
      maxBudget: mainBudget.amount!,
      currentExpenses: -sumCosts.toDouble(),
      isGenerated: true,
    );
  }

  Future<List<BudgetViewData>> getBudgetViewData(DateTime date) async {
    final budgets = await _service.getBudgetsForDate(date);
    return await _mapBudgetToViewData(budgets);
  }

  double _calculateBudgetCap(BudgetCap cap, double income) {
    if (cap.type == CapType.amount) {
      return cap.value;
    }
    return income * cap.value;
  }

  Future<List<BudgetViewData>> _mapBudgetToViewData(
      List<Budget> budgets,) async {
    final month = _algService.state.shownMonth;
    final income = await _statService.getSerialIncomeForMonth(month);

    final iter = budgets.map((budget) async {
      final expenses = await _statService
          .getExpensesForCategories(<String>{...budget.categories}, month);

      final upcomingExpenses = expenses.isEmpty
          ? 0.0
          : expenses.values
              .map((e) => e.upcoming)
              .reduce((v, e) => v += e)
              .toDouble();
      final currentExpenses = expenses.isEmpty
          ? 0.0
          : expenses.values
              .map((e) => e.current)
              .reduce((v, e) => v += e)
              .toDouble();

      final catData = expenses.entries
          .map((entry) => (name: entry.key, expenses: entry.value))
          .toList();

      final viewData = BudgetViewData(
        name: budget.name,
        upcomingExpenses: upcomingExpenses,
        currentExpenses: currentExpenses,
        cap: _calculateBudgetCap(
          budget.cap,
          (income.current + income.upcoming).toDouble(),
        ),
        categories: catData,
      );
      return viewData;
    });
    final result = await Future.wait(iter, eagerError: true);
    return result;
  }
}
