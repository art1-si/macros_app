import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mcr/bloc/bloc_meals.dart';
import 'package:mcr/logic/day_selector_model.dart';
import 'package:provider/provider.dart';

class WeekdaysSelector extends StatefulWidget {
  @override
  _WeekdaysSelectorState createState() => _WeekdaysSelectorState();
}

class _WeekdaysSelectorState extends State<WeekdaysSelector> {
  final blocMeal = MealsBloc();
  final dateSelector = DaySelectorModel();
  int datePassed = 0;

  @override
  Widget build(BuildContext context) {
    var datePassing = Provider.of<DaySelectorModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Consumer<DaySelectorModel>(builder: (context, dateSe, child) {
            return GestureDetector(
              onTap: () {
                datePassed--;
                datePassing.daySelectorSub();
              },
              child: Container(
                color: Colors.transparent,
                width: 50,
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.grey,
                ),
              ),
            );
          }),
          Container(
            height: 40.0,
            child: GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Container(
                  height: 10,
                  width: 220.0,
                  child: Center(child: Consumer<DaySelectorModel>(
                      builder: (context, dateSe, child) {
                    String date;
                    if ("${dateSe.daySelected.day}${dateSe.daySelected.month}${dateSe.daySelected.year}" ==
                        "${dateSe.today.day}${dateSe.today.month}${dateSe.today.year}") {
                      date = 'Today';
                    } else if ("${dateSe.daySelected.day}${dateSe.daySelected.month}${dateSe.daySelected.year}" ==
                        "${dateSe.yesterday.day}${dateSe.yesterday.month}${dateSe.yesterday.year}") {
                      date = 'Yesterday';
                    } else if ("${dateSe.daySelected.day}${dateSe.daySelected.month}${dateSe.daySelected.year}" ==
                        "${dateSe.tomorrow.day}${dateSe.tomorrow.month}${dateSe.tomorrow.year}") {
                      date = 'Tomorrow';
                    } else {
                      date =
                          "${DateFormat('EEEE').format(dateSe.daySelected)} ${DateFormat('dd').format(dateSe.daySelected)}  ${DateFormat('MMMM').format(dateSe.daySelected)}";
                    }
                    return Container(
                        width: 250,
                        child: Center(
                          child: Text("$date",
                              style: Theme.of(context).textTheme.subtitle2),
                        ));
                  })),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              datePassing.daySelectorAdd();
            },
            child: Container(
              color: Colors.transparent,
              width: 50,
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
