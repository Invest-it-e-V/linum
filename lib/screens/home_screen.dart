//  Home Screen - The Home Screen of the App containing Statistical Info in the HomeScreenCard as well as a list of transactions in a specified month.
//
//  Author: SoTBurst, thebluebaronx, NightmindOfficial
//  Co-Author: damattl
/// PAGE INDEX 0

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linum/navigation/main_router_delegate.dart';
import 'package:linum/navigation/main_routes.dart';
import 'package:linum/providers/algorithm_provider.dart';
import 'package:linum/providers/balance_data_provider.dart';
import 'package:linum/providers/pin_code_provider.dart';
import 'package:linum/utilities/backend/local_app_localizations.dart';
import 'package:linum/utilities/frontend/filters.dart';
import 'package:linum/utilities/frontend/silent_scroll.dart';
import 'package:linum/widgets/home_screen/home_screen_listview.dart';
import 'package:linum/widgets/screen_skeleton/app_bar_action.dart';
import 'package:linum/widgets/screen_skeleton/screen_skeleton.dart';
import 'package:provider/provider.dart';

/// Page Index: 0
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void resetAlgorithmProvider() {
    final AlgorithmProvider algorithmProvider =
    Provider.of<AlgorithmProvider>(context);

    if (algorithmProvider.currentFilter == Filters.noFilter) {
      algorithmProvider.resetCurrentShownMonth();
      algorithmProvider.setCurrentFilterAlgorithm(
        Filters.inBetween(
          Timestamp.fromDate(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
            ).subtract(const Duration(microseconds: 1)),
          ),
          Timestamp.fromDate(
            DateTime(
              DateTime.now().year,
              DateTime.now().month + 1,
            ),
          ),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    final BalanceDataProvider balanceDataProvider =
        Provider.of<BalanceDataProvider>(context);

    final PinCodeProvider pinCodeProvider =
        Provider.of<PinCodeProvider>(context);

    resetAlgorithmProvider();
    // AlgorithmProvider algorithmProvider =
    //     Provider.of<AlgorithmProvider>(context, listen: false);

    // if (!algorithmProvider.currentFilter(
    //     {"time": Timestamp.fromDate(DateTime.now().add(Duration(days: 1)))})) {
    //   algorithmProvider.setCurrentFilterAlgorithm(
    //       AlgorithmProvider.olderThan(Timestamp.fromDate(DateTime.now())));
    // }

    return ScreenSkeleton(
      head: 'Home',
      isInverted: true,
      hasHomeScreenCard: true,
      leadingAction: AppBarAction.fromPreset(DefaultAction.academy),
      actions: [
        if (pinCodeProvider.pinSet)
          (BuildContext context) => AppBarAction.fromParameters(
                icon: Icons.lock_rounded,
                ontap: () {
                  pinCodeProvider.resetSession();
                },
                key: const Key("pinRecallButton"),
              ),
        AppBarAction.fromPreset(DefaultAction.settings),
      ],
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 25, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        AppLocalizations.of(context)!.translate(
                          'home_screen/label-recent-transactions',
                        ),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.find<MainRouterDelegate>().replaceLastRoute(MainRoute.budget);
                      },
                      child: Text(
                        AppLocalizations.of(context)!
                            .translate('home_screen/button-show-more'),
                        style: Theme.of(context).textTheme.overline?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: ScrollConfiguration(
                    behavior: SilentScroll(),
                    child: balanceDataProvider.fillListViewWithData(
                      HomeScreenListView(),
                      context: context,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
