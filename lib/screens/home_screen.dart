import 'package:flutter/material.dart';
import 'package:linum/providers/balance_data_provider.dart';
import 'package:linum/widgets/home_screen_card.dart';
import 'package:linum/widgets/test_implementation.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    BalanceDataProvider balanceDataProvider =
        Provider.of<BalanceDataProvider>(context);

    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //the top, green lip
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.zero,
                bottom: Radius.circular(40),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        //where the balance is shown to the user
        HomeScreenCard(monthlyBudget: 4.20),
        balanceDataProvider.fillListViewWithData(TestListView()),
      ],
    );
  }
}
/* ListView(
                children: snapshot.data == null
                    ? [Text("Error")]
                    : snapshot.data!.docs.map((singleBalance) {
                        return ListTile(
                          title:
                              Text(singleBalance["singleBalance"].toString()),
                          onLongPress: () {
                            singleBalance.reference.delete();
                          },
                        );
                      }).toList());*/