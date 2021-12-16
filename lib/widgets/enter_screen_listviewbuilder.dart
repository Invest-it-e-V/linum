import 'package:flutter/material.dart';

class EnterScreenListViewBuilder extends StatefulWidget {
  List categories;
  List categoriesExpenses;
  EnterScreenListViewBuilder(
      {Key? key, required this.categories, required this.categoriesExpenses})
      : super(key: key);

  @override
  _EnterScreenListViewBuilderState createState() =>
      _EnterScreenListViewBuilderState();
}

class _EnterScreenListViewBuilderState
    extends State<EnterScreenListViewBuilder> {
  final List<String> _categoriesCategory = [
    "Category 1",
    "Category 2",
    "Category 3",
    "Category 4",
    "Category 5",
    "Category 6",
  ];

  final List<String> _categoriesAccount = [
    "Account 1",
    "Account 2",
    "Account 3",
    "Account 4",
    "Account 5",
    "Account 6",
  ];

  String selectedCategory = "";
  String selectedAccount = "";
  String selectedRepetition = "";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: widget.categories.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => _onCategoryPressed(index, widget.categoriesExpenses),
              child: Container(
                height: 50,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.background),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                0.5, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: Icon(widget.categories[index].icon),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(widget.categories[index].type + ":"),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }

  void _onCategoryPressed(int index, categoriesExpenses) {
    print(
      index.toString(),
    );
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Container(
                      child: Icon(categoriesExpenses.elementAt(index).icon),
                    ),
                  ),
                  Column(
                    children: [
                      Text(categoriesExpenses.elementAt(index).type),
                      Text("Hello"),
                    ],
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  height: 300,
                  child: index == 0
                      ? ListView.builder(
                          itemCount: _categoriesCategory.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Icon(Icons.ac_unit),
                              title: Text(_categoriesCategory[index]),
                              onTap: () => _selectCategoryItem(
                                _categoriesCategory[index],
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: _categoriesAccount.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Icon(Icons.headphones),
                              title: Text(_categoriesAccount[index]),
                              onTap: () => _selectAccountItem(
                                _categoriesAccount[index],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectCategoryItem(String name) {
    Navigator.pop(context);
    setState(() {
      selectedCategory = name;
    });
  }

  void _selectAccountItem(String name) {
    Navigator.pop(context);
    setState(() {
      selectedAccount = name;
    });
  }
}
