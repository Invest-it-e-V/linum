import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linum/backend_functions/local_app_localizations.dart';
import 'package:linum/frontend_functions/size_guide.dart';
import 'package:linum/providers/balance_data_provider.dart';
import 'package:linum/providers/enter_screen_provider.dart';
import 'package:linum/widgets/enter_screen/enter_screen_list.dart';
import 'package:linum/widgets/enter_screen/enter_screen_top_input_field.dart';
import 'package:provider/provider.dart';

class EnterScreen extends StatefulWidget {
  EnterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EnterScreen> createState() => _EnterScreenState();
}

class _EnterScreenState extends State<EnterScreen> {
  @override
  Widget build(BuildContext context) {
    EnterScreenProvider enterScreenProvider =
        Provider.of<EnterScreenProvider>(context);
    BalanceDataProvider balanceDataProvider =
        Provider.of<BalanceDataProvider>(context);
    //to format the date time it has to be parsed to a string, get formatted
    //and get parsed back to a date time
    String selectedDateStringFormatted =
        enterScreenProvider.selectedDate.toString().split(' ')[0];
    DateTime selectedDateDateTimeFormatted =
        DateTime.parse(selectedDateStringFormatted);

    final formKey = enterScreenProvider.formKey;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   leading: BackButton(),
        // ),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //the top, green lip
              EnterScreenTopInputField(),
              enterScreenProvider.isTransaction
                  ? Center(
                      child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          "Coming soon",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ))
                  : EnterScreenList(),
              Expanded(
                child:
                    Container(color: Theme.of(context).colorScheme.background),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.button,
                        primary: Theme.of(context).colorScheme.primary,
                        onPrimary: Theme.of(context).colorScheme.background,
                        onSurface: Colors.white,
                        fixedSize: Size(proportionateScreenWidth(300),
                            proportionateScreenHeight(40))),
                    onPressed: () {
                      // if (!enterScreenProvider.formKey.currentState
                      //     .validate()) {
                      //   return;
                      // }
                      Navigator.of(context).pop();
                      //a single balance is added to the balancedataprovider
                      //with the values of the input from the user
                      enterScreenProvider.editMode
                          ? balanceDataProvider.updateSingleBalance(
                              amount: _amountChooser(enterScreenProvider),
                              category: enterScreenProvider.category,
                              currency: "EUR",
                              name: enterScreenProvider.name == ""
                                  ? enterScreenProvider.category
                                  : enterScreenProvider.name,
                              time: Timestamp.fromDate(
                                  selectedDateDateTimeFormatted))
                          : balanceDataProvider.addSingleBalance(
                              amount: _amountChooser(enterScreenProvider),
                              category: enterScreenProvider.category,
                              currency: "EUR",
                              name: enterScreenProvider.name == ""
                                  ? enterScreenProvider.category
                                  : enterScreenProvider.name,
                              time: Timestamp.fromDate(
                                  selectedDateDateTimeFormatted));
                    },
                    child: Text(AppLocalizations.of(context)!
                        .translate('enter_screen/button-save-entry')),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //if the amount is entered in expenses, it's set to the negative equivalent if
  //the user did not accidentally press the minus
  num _amountChooser(EnterScreenProvider enterScreenProvider) {
    if (enterScreenProvider.isExpenses) {
      if (enterScreenProvider.amount < 0) {
        return enterScreenProvider.amount;
      } else
        return -enterScreenProvider.amount;
    } else
      return enterScreenProvider.amount;
  }
}
