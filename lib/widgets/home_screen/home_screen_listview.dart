import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:linum/backend_functions/local_app_localizations.dart';
import 'package:linum/providers/account_settings_provider.dart';
import 'package:linum/providers/balance_data_provider.dart';
import 'package:linum/providers/enter_screen_provider.dart';
import 'package:linum/screens/enter_screen.dart';
import 'package:linum/widgets/abstract/balance_data_list_view.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:linum/widgets/budget_screen/time_widget.dart';
import 'package:provider/provider.dart';

class HomeScreenListView implements BalanceDataListView {
  late ListView _listview;

  HomeScreenListView() {
    _listview = new ListView();
  }

  List<Map<String, dynamic>> _timeWidgets = [
    {
      "widget": TimeWidget(displayValue: 'listview/label-today'),
      "time": DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(Duration(days: 1, microseconds: -1))
    },
    {
      "widget": TimeWidget(displayValue: 'listview/label-yesterday'),
      "time": DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(days: 0, microseconds: 1))
    },
    {
      "widget": TimeWidget(displayValue: 'listview/label-lastweek'),
      "time": DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(days: 1, microseconds: 1))
    },
    {
      "widget": TimeWidget(displayValue: 'listview/label-thismonth'),
      "time": DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(days: 7, microseconds: 1))
    },
    // {
    //   "widget": TimeWidget(displayValue: 'Älter'),
    //   "time": DateTime(DateTime.now().year, DateTime.now().month)
    //       .subtract(Duration(days: 0, microseconds: 1))
    // },
  ];

  @override
  void setBalanceData(List<dynamic> balanceData,
      {required BuildContext context}) {
    initializeDateFormatting();

    String langCode = AppLocalizations.of(context)!.locale.languageCode;

    DateFormat formatter = DateFormat('EEEE, dd. MMMM yyyy', langCode);

    DateFormat monthFormatter = DateFormat('MMMM', langCode);
    DateFormat monthAndYearFormatter = DateFormat('MMMM yyyy', langCode);
    BalanceDataProvider balanceDataProvider =
        Provider.of<BalanceDataProvider>(context);

    AccountSettingsProvider accountSettingsProvider =
        Provider.of<AccountSettingsProvider>(context);

    // remember last used index in the list
    int currentIndex = 0;
    DateTime? currentTime;

    //log(balanceData.toString());
    List<Widget> list = [];
    if (balanceData.length == 0) {
      list.add(TimeWidget(displayValue: "listview/label-no-entries"));
    } else if (balanceData[0] != null && balanceData[0]["Error"] == null) {
      balanceData.forEach(
        (arrayElement) {
          DateTime date = arrayElement["time"].toDate() as DateTime;
          bool isFutureItem = date.isAfter(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day + 1,
          ).subtract(Duration(microseconds: 1)));

          if (currentTime == null) {
            currentTime = DateTime(date.year, date.month + 2);
          }
          if (isFutureItem) {
            if (date.isBefore(currentTime!)) {
              if (list.isEmpty &&
                  DateTime(date.year, date.month) ==
                      DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                      )) {
                list.add(TimeWidget(
                  displayValue: "listview/label-future",
                ));
              } else {
                list.add(TimeWidget(
                  displayValue: date.year == DateTime.now().year
                      ? monthFormatter.format(date)
                      : monthAndYearFormatter.format(date),
                  isTranslated: true,
                ));
              }
              currentTime = DateTime(date.year, date.month);
            }
          } else if (currentIndex < _timeWidgets.length &&
              date.isBefore(_timeWidgets[currentIndex]["time"])) {
            currentTime = DateTime(DateTime.now().year, DateTime.now().month)
                .subtract(Duration(days: 0, microseconds: 1));
            while (currentIndex < (_timeWidgets.length - 1) &&
                date.isBefore(_timeWidgets[currentIndex + 1]["time"])) {
              currentIndex++;
            }
            if (date.isBefore(_timeWidgets[currentIndex]["time"]) &&
                date.isAfter(currentTime!)) {
              list.add(_timeWidgets[currentIndex]["widget"]);
            }

            currentIndex++;
          }
          if (date.isBefore(DateTime.now()) &&
              (list.length == 0 || list.last.runtimeType != TimeWidget) &&
              date.isBefore(currentTime!)) {
            list.add(TimeWidget(
                displayValue: date.year == DateTime.now().year
                    ? monthFormatter.format(date)
                    : monthAndYearFormatter.format(date),
                isTranslated: true));
            currentTime = DateTime(date.year, date.month - 1);

            currentIndex = 4; // idk why exactly but now we are save
          }

          list.add(GestureDetector(
            onTap: () {
              BalanceDataProvider balanceDataProvider =
                  Provider.of<BalanceDataProvider>(context, listen: false);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (innerContext) {
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider<EnterScreenProvider>(
                          create: (_) {
                            return EnterScreenProvider(
                              id: arrayElement["id"],
                              amount: arrayElement["amount"],
                              category: arrayElement["category"],
                              name: arrayElement["name"],
                              selectedDate:
                                  (arrayElement["time"] as Timestamp).toDate(),
                              editMode: true,
                            );
                          },
                        ),
                        ChangeNotifierProvider<BalanceDataProvider>(
                          create: (_) {
                            return balanceDataProvider..dontDisposeOneTime();
                          },
                        ),
                        ChangeNotifierProvider<AccountSettingsProvider>(
                          create: (_) {
                            return accountSettingsProvider
                              ..dontDisposeOneTime();
                          },
                        ),
                      ],
                      child: EnterScreen(),
                    );
                  },
                ),
              );
            },
            //print(arrayElement["amount"].toString()),
            child: Dismissible(
              background: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        spacing: 16.0,
                        children: [
                          Text(
                              AppLocalizations.of(context)!.translate(
                                  "listview/dismissible/label-delete"),
                              style: Theme.of(context).textTheme.button),
                          Icon(
                            Icons.delete,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                color: Colors.red,
              ),
              key: arrayElement["id"] != null
                  ? Key(arrayElement["id"])
                  : Key("one"),
              /*confirmDismiss: (DismissDirection direction) {
                //_alertDialogFunction();
                if (arrayElement["repeatId"] != null) {
                  return showAlertDialog(
                      context, balanceDataProvider, arrayElement);
                } else {
                  balanceDataProvider.removeSingleBalance(arrayElement["id"]);
                  return Future<bool>.value(true);
                }
              },*/
              direction: DismissDirection.endToStart,
              dismissThresholds: {DismissDirection.endToStart: 0.5},
              confirmDismiss: arrayElement["repeatId"] != null
                  ? (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                AppLocalizations.of(context)!.translate(
                                    'enter_screen/delete-entry/dialog-label-title'),
                                style: Theme.of(context).textTheme.headline4),
                            content: Text(
                              AppLocalizations.of(context)!.translate(
                                  "enter_screen/delete-entry/dialog-label-deleterep"),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  balanceDataProvider.removeSingleBalance(
                                    arrayElement["id"],
                                  );
                                  Navigator.of(context).pop(true);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.translate(
                                      "enter_screen/delete-entry/dialog-button-onlyonce"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  balanceDataProvider.removeRepeatedBalance(
                                    id: arrayElement["repeatId"],
                                    removeType: RemoveType.ALL_AFTER,
                                    time: arrayElement["time"],
                                  );
                                  Navigator.of(context).pop(true);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.translate(
                                      "enter_screen/delete-entry/dialog-button-fromnow"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  balanceDataProvider.removeRepeatedBalance(
                                    id: arrayElement["repeatId"],
                                    removeType: RemoveType.ALL,
                                    time: arrayElement["time"],
                                  );
                                  Navigator.of(context).pop(true);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.translate(
                                      "enter_screen/delete-entry/dialog-button-allentries"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(
                                  AppLocalizations.of(context)!.translate(
                                      "enter_screen/delete-entry/dialog-button-cancel"),
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  : (DismissDirection direction) async {
                      /*ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Hi, I am snackbar"),
                          behavior: SnackBarBehavior.floating,
                          action: SnackBarAction(
                            label: "Undo",
                            textColor: Theme.of(context).colorScheme.onPrimary,
                            onPressed: () {},
                          ),
                        ),
                      );*/
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                AppLocalizations.of(context)!.translate(
                                    'enter_screen/delete-entry/dialog-label-title'),
                                style: Theme.of(context).textTheme.headline4),
                            content: Text(AppLocalizations.of(context)!.translate(
                                'enter_screen/delete-entry/dialog-label-delete')),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(
                                  AppLocalizations.of(context)!.translate(
                                      "enter_screen/delete-entry/dialog-button-cancel"),
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  balanceDataProvider.removeSingleBalance(
                                    arrayElement["id"],
                                  );
                                  Navigator.of(context).pop(true);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.translate(
                                      "enter_screen/delete-entry/dialog-button-delete"),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
              /*showModalBottomSheet(
                      isDismissible: false,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 200,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  balanceDataProvider
                                      .removeSingleBalance(arrayElement["id"]);
                                },
                                child: Text("Nur diese Transaktion löschen"),
                              ),
                              GestureDetector(
                                onTap: () => balanceDataProvider
                                    .removeSingleBalance(arrayElement["id"]),
                                child: Text("Nur diese Transaktion löschen"),
                              ),
                              GestureDetector(
                                child: Text("Abbrechen"),
                                onTap: () => Navigator.pop(context),
                              ),
                                GestureDetector(
                                onTap: () =>
                                    balanceDataProvider.removeRepeatedBalance(
                                        id: arrayElement["id"],
                                        removeType: RemoveType.ALL),
                              ),
                              GestureDetector(
                                child: Text("Alle Transaktionen löschen"),
                                onTap: () =>
                                    balanceDataProvider.removeRepeatedBalance(
                                        id: arrayElement["id"],
                                        removeType: RemoveType.ALL_AFTER),
                              )
                            ],
                          ),
                        );
                      });*/

              child: ListTile(
                leading: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: isFutureItem
                          ? arrayElement['amount'] > 0
                              ? Theme.of(context)
                                  .colorScheme
                                  .tertiary // FUTURE INCOME BACKGROUND
                              : Theme.of(context).colorScheme.errorContainer
                          // FUTURE EXPENSE BACKGROUND
                          : arrayElement['amount'] > 0
                              ? Theme.of(context)
                                  .colorScheme
                                  .secondary // PRESENT INCOME BACKGROUND
                              : Theme.of(context)
                                  .colorScheme
                                  .secondary, // PRESENT EXPENSE BACKGROUND
                      child: arrayElement['amount'] > 0
                          ? Icon(
                              AccountSettingsProvider
                                      .standardCategoryIncomes[
                                          EnumToString.fromString(
                                              StandardCategoryIncome.values,
                                              arrayElement['category'])]
                                      ?.icon ??
                                  Icons.error,
                              color: isFutureItem
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onPrimary // FUTURE INCOME ICON
                                  : Theme.of(context)
                                      .colorScheme
                                      .tertiary // PRESENT INCOME ICON
                              )
                          : Icon(
                              AccountSettingsProvider
                                      .standardCategoryExpenses[
                                          EnumToString.fromString(
                                              StandardCategoryExpense.values,
                                              arrayElement['category'])]
                                      ?.icon ??
                                  Icons.error,
                              color: isFutureItem
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onPrimary // FUTURE EXPENSE ICON
                                  : Theme.of(context)
                                      .colorScheme
                                      .errorContainer, // PRESENT EXPENSE ICON
                            ),
                    ),
                    arrayElement["repeatId"] != null
                        ? Positioned(
                            bottom: 18,
                            left: 18,
                            child: Icon(Icons.repeat,
                                color: Theme.of(context).colorScheme.secondary),
                          )
                        : SizedBox(),
                  ],
                ),
                title: Text(
                  arrayElement["name"] != ""
                      ? arrayElement["name"]
                      : translateCategory(arrayElement["category"],
                          arrayElement["amount"] <= 0, context),
                  style: isFutureItem
                      ? Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).colorScheme.onSurface)
                      : Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  formatter
                      .format(
                        arrayElement["time"].toDate(),
                      )
                      .toUpperCase(),
                  style: isFutureItem
                      ? Theme.of(context).textTheme.overline!.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Theme.of(context).colorScheme.onSurface,
                          )
                      : Theme.of(context).textTheme.overline,
                ),
                trailing: Text(
                  arrayElement["amount"].toStringAsFixed(2) + "€",
                  style: arrayElement["amount"] <= 0
                      ? Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Theme.of(context).colorScheme.error)
                      : Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ),
          ));
        },
      );
    } else {
      // log("HomeScreenListView: " + balanceData[0]["Error"].toString());
    }
    _listview = ListView(children: list, padding: EdgeInsets.zero);
  }

  String translateCategory(
      String category, bool isExpense, BuildContext context) {
    if (isExpense) {
      return AppLocalizations.of(context)!.translate(AccountSettingsProvider
              .standardCategoryExpenses[EnumToString.fromString(
                  StandardCategoryExpense.values, category)]
              ?.label ??
          ""); // TODO @Nightmind you could add a String here that will show something like "error translating your category"
    } else if (!isExpense) {
      return AppLocalizations.of(context)!.translate(AccountSettingsProvider
              .standardCategoryIncomes[EnumToString.fromString(
                  StandardCategoryIncome.values, category)]
              ?.label ??
          ""); // TODO @Nightmind you could add a String here that will show something like "error translating your category"
    }
    return "Error"; // This should never happen.
  }

  @override
  ListView get listview => _listview;
}
