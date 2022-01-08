import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:linum/frontend_functions/size_guide.dart';
import 'package:linum/providers/enter_screen_provider.dart';
import 'package:linum/widgets/text_container.dart';
import 'package:provider/provider.dart';

class EnterScreenTopInputField extends StatefulWidget {
  EnterScreenTopInputField({
    Key? key,
  }) : super(key: key);

  @override
  _EnterScreenTopInputFieldState createState() =>
      _EnterScreenTopInputFieldState();
}

class _EnterScreenTopInputFieldState extends State<EnterScreenTopInputField> {
  TextEditingController myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    myController = TextEditingController();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EnterScreenProvider enterScreenProvider =
        Provider.of<EnterScreenProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.zero,
        bottom: Radius.circular(40),
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        width: proportionateScreenWidth(375),
        height: proportionateScreenHeight(164),
        color: Theme.of(context).colorScheme.primary,
        child: GestureDetector(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: EdgeInsets.only(left: 50),
                    constraints: BoxConstraints(),
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                    color: Colors.white,
                  ),
                ),
                //TODO eliminate the small bubble below the disabled color

                TextField(
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  controller: myController,
                  showCursor: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.blue,
                    filled: true,
                    isDense: true,
                    hintText: enterScreenProvider.isExpenses ? " 0.0" : " 0.0",
                    prefixIcon: enterScreenProvider.isExpenses
                        ? Icon(Icons.remove)
                        : Icon(Icons.add),
                    prefixIconColor: Colors.red,
                    hintStyle: TextStyle(
                      color: _colorPicker(enterScreenProvider, context),
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(0),
                  ),
                  style: TextStyle(
                      color: _colorPicker(enterScreenProvider, context),
                      fontSize: 30),
                  onChanged: (String _) {
                    setState(() {
                      enterScreenProvider.setAmount(
                          double.tryParse(myController.text) == null
                              ? 0.0
                              : double.tryParse(myController.text)!);
                    });
                    //print(enterScreenProvider.amount);
                  },
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            enterScreenProvider.setIsExpenses(true);
                            enterScreenProvider.setIsIncome(false);
                            enterScreenProvider.setIsTransaction(false);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: enterScreenProvider.isExpenses
                              ? TextContainer(
                                  //context: context,
                                  transactionClass: "Ausgaben",
                                )
                              : Center(
                                  child: Text(
                                  "Ausgaben",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            enterScreenProvider.setIsExpenses(false);
                            enterScreenProvider.setIsIncome(true);
                            enterScreenProvider.setIsTransaction(false);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: enterScreenProvider.isIncome
                              ? TextContainer(
                                  //context: context,
                                  transactionClass: "Einkommen",
                                )
                              : Center(
                                  child: Text(
                                  "Einkommen",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            enterScreenProvider.setIsExpenses(false);
                            enterScreenProvider.setIsIncome(false);
                            enterScreenProvider.setIsTransaction(true);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: enterScreenProvider.isTransaction
                              ? TextContainer(
                                  //context: context,
                                  transactionClass: "Transaktion",
                                )
                              : Center(
                                  child: Text(
                                    "Transaktion",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _colorPicker(EnterScreenProvider enterScreenProvider, context) {
    if (enterScreenProvider.isExpenses) {
      return Theme.of(context).colorScheme.error;
    } else if (enterScreenProvider.isIncome) {
      return Theme.of(context).colorScheme.background;
    }
    return Theme.of(context).colorScheme.secondary;
  }
}
