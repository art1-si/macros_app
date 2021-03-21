import 'package:flutter/material.dart';
import 'package:mcr/db/breakfast_db_provider.dart';
import 'package:mcr/logic/date_formatter.dart';
import 'package:mcr/logic/day_selector_model.dart';
import 'package:mcr/models/breakfast_model.dart';
import 'package:mcr/widgets/add_button.dart';
import 'package:provider/provider.dart';

class MealWidget extends StatelessWidget {
  final mealBloc;
  final String mealName;
  final String mealType;

  MealWidget({
    Key key,
    this.mealBloc,
    this.mealName,
    this.mealType,
  }) : super(key: key);

  _deleteProduct(int id) async {
    await db.deleteMeal(id);
  }

  void _onLongPressShowBottomSheet(context, int id) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Colors.white54,
                ),
                title: Text("Delete"),
                onTap: () async {
                  _deleteProduct(id);
                  Navigator.of(context, rootNavigator: true).pop();
                  Provider.of<DaySelectorModel>(context, listen: false)
                      .justNotify();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.edit,
                  color: Colors.white54,
                ),
                title: Text("Edit"),
                //onTap: _deleteProduct(id),
              ),
            ],
          ),
        );
      },
    );
  }

  final BreakfastDatabase db = BreakfastDatabase();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: mealBloc,
        builder: (context, AsyncSnapshot<List<BreakfastModel>> snapshot) {
          double totalBreakfastCalories = 0;
          double totalBreakfastFat = 0;
          double totalBreakfastCarbs = 0;
          double totalBreakfastProtein = 0;
          if (!snapshot.hasData || snapshot.data.length == 0) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        height: 55.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.elliptical(10, 20))),
                                height: 55,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 20),
                                  child: Center(
                                    child: Text('$mealName',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                          "Kcal: ${totalBreakfastCalories.toInt()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                    ),
                                    AddButton(selectedDb: "$mealType"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Center(
                            child: Text(
                              "Fat: ${roundDouble(totalBreakfastFat, 1).toInt()}",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Center(
                            child: Text(
                              "Carbs: ${roundDouble(totalBreakfastCarbs, 1).toInt()}",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Center(
                            child: Text(
                              "Protein: ${roundDouble(totalBreakfastProtein, 1).toInt()}",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            for (int i = 0; i < snapshot.data.length; i++) {
              totalBreakfastCalories += snapshot.data[i].breakfastCalories;
              totalBreakfastFat += snapshot.data[i].breakfastFat;
              totalBreakfastCarbs += snapshot.data[i].breakfastCarbs;
              totalBreakfastProtein += snapshot.data[i].breakfastProtein;
            }
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        height: 55.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.elliptical(10, 20))),
                                height: 55,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 20),
                                    child: Center(
                                      child: Text('$mealName',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                    ))),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                        "Kcal: ${totalBreakfastCalories.toInt()}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                  ),
                                  AddButton(selectedDb: "$mealType"),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        totalBreakfastCalories =
                            snapshot.data[index].breakfastCalories +
                                totalBreakfastCalories;
                        String brandd;
                        (snapshot.data[index].brand == null)
                            ? brandd = ""
                            : brandd = " (${snapshot.data[index].brand})";
                        return Column(
                          children: <Widget>[
                            InkWell(
                              onLongPress: () async {
                                _onLongPressShowBottomSheet(
                                    context, snapshot.data[index].id);
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0, bottom: 4),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            "${snapshot.data[index].breakfastProductName}"),
                                                    TextSpan(
                                                        text: "$brandd",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption)
                                                  ]),
                                            )),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                                "Price: ${snapshot.data[index].breakfastPrices}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .overline),
                                            Text(
                                                'Fat: ${snapshot.data[index].breakfastFat}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .overline),
                                            Text(
                                                'Carbs: ${snapshot.data[index].breakfastCarbs}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .overline),
                                            Text(
                                                'Protein: ${snapshot.data[index].breakfastProtein}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .overline),
                                            Text(
                                                'Kcal: ${snapshot.data[index].breakfastCalories}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .overline),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              indent: 50,
                              endIndent: 50,
                              thickness: 1,
                              height: 2,
                            ),
                          ],
                        );
                      }),
                  Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Center(
                            child: Text(
                              "Fat: ${roundDouble(totalBreakfastFat, 1).toInt()}",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Center(
                            child: Text(
                              "Carbs: ${roundDouble(totalBreakfastCarbs, 1).toInt()}",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Center(
                            child: Text(
                              "Protein: ${roundDouble(totalBreakfastProtein, 1).toInt()}",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
