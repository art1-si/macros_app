import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mcr/bloc/bloc_meals.dart';
import 'package:mcr/bloc/bloc_user.dart';
import 'package:mcr/logic/User_provider.dart';
import 'package:mcr/logic/day_selector_model.dart';
import 'package:mcr/logic/tdee_provider.dart';
import 'package:provider/provider.dart';

class FcpScaling extends StatefulWidget {
  @override
  _FcpScalingState createState() => _FcpScalingState();
}

class _FcpScalingState extends State<FcpScaling> {
  final bloc = MealsBloc();
  final userBloc = UserBloc();

  double calfat(double userKcalGoal) {
    return (userKcalGoal * 20 / 100) / 9;
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DaySelectorModel>(builder: (context, dateSe, child) {
      bloc.addFatToStream(
          '%${dateSe.daySelected.day}-0${dateSe.daySelected.month}-${dateSe.daySelected.year}%');
      return Container(
        decoration: new BoxDecoration(
          //color: Color(0xff282F3D),
          borderRadius: new BorderRadius.only(
            bottomRight: Radius.circular(0.0),
          ),
        ),
        height: 40,
        //
        child: Consumer<UserProvider>(builder: (context, userProvider, child) {
          double proteinGoal;
          double fatGoal;
          double carbsGoal;
          double userTdee;
          userTdee = goalCalculator(
              userProvider.getUserGender,
              userProvider.getUserWeight,
              userProvider.getUserHeight,
              userProvider.getUserAge,
              userProvider.getUserActivity,
              userProvider.getUserGoal);
          proteinGoal = userProvider.getUserWeight;
          fatGoal = roundDouble((((userTdee) * (25 / 100)) / 9), 1);
          carbsGoal =
              ((userTdee - (proteinGoal * 4) - ((userTdee) * (25 / 100))) / 4);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StreamBuilder(
                  stream: bloc.totalPrice,
                  builder: (context, AsyncSnapshot<double> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          child: Text(
                        'COST:\n 1',
                        style: Theme.of(context).textTheme.headline3,
                      ));
                    } else {
                      return Container(
                          child: Column(
                        children: <Widget>[
                          Text(
                            'COST',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              color: Theme.of(context).primaryColorLight,
                              width: 10,
                              height: 1,
                            ),
                          ),
                          Text("${roundDouble(snapshot.data, 2)}",
                              style: Theme.of(context).textTheme.headline2)
                        ],
                      ));
                    }
                  }),
              StreamBuilder(
                  stream: bloc.totalFat,
                  builder: (context, AsyncSnapshot<double> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          child: Text(
                        'Fat: 02',
                        style: Theme.of(context).textTheme.headline3,
                      ));
                    } else {
                      return Container(
                          child: Column(
                        children: <Widget>[
                          Text(
                            'FAT',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              color: Theme.of(context).primaryColorLight,
                              width: 10,
                              height: 1,
                            ),
                          ),
                          Text("${snapshot.data.toInt()} / ${fatGoal.toInt()}",
                              style: Theme.of(context).textTheme.headline2)
                        ],
                      ));
                    }
                  }),
              StreamBuilder(
                  stream: bloc.totalCarbs,
                  builder: (context, AsyncSnapshot<double> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          child: Text(
                        'Carbss: 0',
                        style: Theme.of(context).textTheme.headline3,
                      ));
                    } else {
                      return Container(
                          child: Column(
                        children: <Widget>[
                          Text(
                            'CARBS',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              color: Theme.of(context).primaryColorLight,
                              width: 10,
                              height: 1,
                            ),
                          ),
                          Text(
                              "${snapshot.data.toInt()} / ${carbsGoal.toInt()}",
                              style: Theme.of(context).textTheme.headline2)
                        ],
                      ));
                    }
                  }),
              StreamBuilder(
                  stream: bloc.totalProtein,
                  builder: (context, AsyncSnapshot<double> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          child: Text(
                        'Proteinss: 0',
                        style: Theme.of(context).textTheme.headline3,
                      ));
                    } else {
                      return Container(
                          child: Column(
                        children: <Widget>[
                          Text(
                            'PROTEIN',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              color: Theme.of(context).primaryColorLight,
                              width: 10,
                              height: 1,
                            ),
                          ),
                          Text(
                            "${snapshot.data.toInt()} / ${proteinGoal.toInt()}",
                            style: Theme.of(context).textTheme.headline2,
                          )
                        ],
                      ));
                    }
                  }),
            ],
          );
        }),
      );
    });
  }
}
