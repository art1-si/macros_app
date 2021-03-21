import 'package:flutter/material.dart';
import 'package:mcr/bloc/bloc_meals.dart';
import 'package:mcr/componets/bottom_icon_row.dart';
import 'package:mcr/logic/day_selector_model.dart';
import 'package:mcr/widgets/meal_widget.dart';
import 'package:mcr/widgets/weekdays_selector.dart';
import 'package:mcr/widgets/macros_scaling.dart';
import 'package:mcr/widgets/fcp_scaling.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final bloc = MealsBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ChangeNotifierProvider(
            create: (context) => DaySelectorModel(),
            child: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                centerTitle: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(
                  'Macros',
                  style: Theme.of(context).textTheme.headline6,
                ),
                pinned: false,
                expandedHeight: 180.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 50,
                        color: Colors.transparent,
                      ),
                      MacrosScaling(),
                      FcpScaling(),
                    ],
                  ),
                ),
              ),
              Consumer<DaySelectorModel>(builder: (context, dateSe, child) {
                bloc.addMealsToStream(
                    '%${dateSe.daySelected.day}-0${dateSe.daySelected.month}-${dateSe.daySelected.year}%');
                return SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                  WeekdaysSelector(),
                  MealWidget(
                    mealBloc: bloc.breakfastList,
                    mealName: "Breakfast",
                    mealType: "breakfast",
                  ),
                  Divider(
                    indent: 150,
                    endIndent: 150,
                    height: 15,
                    thickness: 0.1,
                  ),
                  MealWidget(
                    mealBloc: bloc.lunchList,
                    mealName: "Lunch",
                    mealType: "lunch",
                  ),
                  Divider(
                    indent: 150,
                    endIndent: 150,
                    height: 15,
                    thickness: 0.1,
                  ),
                  MealWidget(
                    mealBloc: bloc.dinnerList,
                    mealName: "Dinner",
                    mealType: "dinner",
                  ),
                  Divider(
                    indent: 150,
                    endIndent: 150,
                    height: 15,
                    thickness: 0.1,
                  ),
                  MealWidget(
                    mealBloc: bloc.snackList,
                    mealName: "Snacks",
                    mealType: "snack",
                  ),
                  Divider(
                    indent: 150,
                    endIndent: 150,
                    height: 15,
                    thickness: 0.1,
                  ),
                  BottomIconsRow(),
                  Divider(
                    indent: 150,
                    endIndent: 150,
                    height: 10,
                    thickness: 0.1,
                  ),
                ]));
              }),
            ]),
          )),
    );
  }
}
