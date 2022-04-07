import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:linum/backend_functions/local_app_localizations.dart';
import 'package:linum/backend_functions/statistic_calculations.dart';
import 'package:linum/frontend_functions/homescreen_card_time_warp.dart';
import 'package:linum/frontend_functions/materialcolor_creator.dart';
import 'package:linum/frontend_functions/size_guide.dart';
import 'package:linum/providers/algorithm_provider.dart';
import 'package:linum/widgets/abstract/abstract_home_screen_card.dart';
import 'package:provider/provider.dart';

class HomeScreenCard extends StatelessWidget {
  final num balance;
  final num income;
  final num expense;

  const HomeScreenCard({
    Key? key,
    required this.balance,
    required this.income,
    required this.expense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlgorithmProvider algorithmProvider =
        Provider.of<AlgorithmProvider>(context);

    final String langCode = AppLocalizations.of(context)!.locale.languageCode;

    final DateFormat dateFormat = DateFormat('MMMM yyyy', langCode);
    DateTime now = DateTime.now();

    // dev.log(algorithmProvider.currentShownMonth.toString());

    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        // Note: Sensitivity is integer used when you don't want to mess up vertical drag
        const int sensitivity = 1;
        if (details.primaryVelocity! > sensitivity) {
          //Right Swipe, going back in time
          goBackInTime(algorithmProvider);
        } else if (details.primaryVelocity! < -sensitivity) {
          goForwardInTime(algorithmProvider);
        }
      },
      onTap: () {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!
              .translate('home_screen_card/home-screen-card-toast'),
          toastLength: Toast.LENGTH_SHORT,
        );
      },
      onLongPress: () {
        goToCurrentTime(algorithmProvider);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(64),
                  blurRadius: 16.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Material(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/v01-cubes-12.png"),
                      opacity: 0.6,
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: proportionateScreenWidth(345),
                  height: proportionateScreenHeight(196),
                  // color: Colors.grey[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            dateFormat.format(
                              algorithmProvider.currentShownMonth,
                            ),
                            style: MediaQuery.of(context).size.height < 650
                                ? Theme.of(context).textTheme.headline5
                                : Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            AppLocalizations.of(context)!.translate(
                                'home_screen_card/label-current-balance'),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              goBackInTime(algorithmProvider);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      balance.toStringAsFixed(2),
                                      style: MediaQuery.of(context)
                                                  .size
                                                  .height <
                                              650
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline2
                                              ?.copyWith(
                                                color: balance < 0
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .error
                                                    : createMaterialColor(
                                                        const Color(0xFF202020),
                                                      ),
                                              )
                                          : Theme.of(context)
                                              .textTheme
                                              .headline1
                                              ?.copyWith(
                                                color: balance < 0
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .error
                                                    : createMaterialColor(
                                                        const Color(0xFF505050),
                                                      ),
                                              ),
                                    ),
                                  ),
                                ),
                                Text(
                                  '€',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              goForwardInTime(algorithmProvider);
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment:
                              algorithmProvider.currentShownMonth !=
                                      DateTime(now.year, now.month)
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_upward_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.translate(
                                        'home_screen_card/label-income',
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline!
                                          .copyWith(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${income.toStringAsFixed(2)} €',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            algorithmProvider.currentShownMonth !=
                                    DateTime(
                                      now.year,
                                      now.month,
                                    )
                                ? Expanded(
                                    child: IconButton(
                                      icon: const Icon(Icons.today_rounded),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withAlpha(64),
                                      onPressed: () {
                                        goToCurrentTime(algorithmProvider);
                                      },
                                    ),
                                  )
                                : Container(),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.translate(
                                        'home_screen_card/label-expenses',
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline!
                                          .copyWith(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${expense.toStringAsFixed(2)} € ',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_downward_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreenCardManager implements AbstractHomeScreenCard {
  late HomeScreenCard _homeScreenCard;
  HomeScreenCardManager() {
    _homeScreenCard = const HomeScreenCard(income: 0, expense: 0, balance: 0);
  }

  @override
  void addStatisticData(StatisticsCalculations? statData) {
    if (statData != null) {
      final num income = statData.sumIncomes;
      final num expense = -statData.sumCosts;
      final num balance = statData.sumBalance;
      _homeScreenCard =
          HomeScreenCard(income: income, expense: expense, balance: balance);
    }
  }

  @override
  Widget get returnWidget => _homeScreenCard;
}
