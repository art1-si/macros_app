import 'dart:math';
import 'package:flutter/material.dart';

import 'package:mcr/bloc/bloc_meals.dart';
import 'package:mcr/bloc/bloc_user.dart';
import 'package:mcr/logic/User_provider.dart';
import 'package:mcr/logic/day_selector_model.dart';
import 'package:mcr/logic/tdee_provider.dart';
import 'package:mcr/widgets/liner_progress.dart';

import 'package:provider/provider.dart';

class MacrosScaling extends StatefulWidget {
  @override
  _MacrosScalingState createState() => _MacrosScalingState();
}

class _MacrosScalingState extends State<MacrosScaling> {
  final bloc = MealsBloc();
  final userBloc = UserBloc();

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
 
  @override
  Widget build(BuildContext context) {
    return Consumer<DaySelectorModel>(builder: (context, dateSe, child) {
      bloc.addFatToStream(
          '%${dateSe.daySelected.day}-0${dateSe.daySelected.month}-${dateSe.daySelected.year}%');
      return Consumer<UserProvider>(builder: (context, userProvider, child) {
        int kcal;
        kcal = roundDouble(
                goalCalculator(
                    userProvider.getUserGender,
                    userProvider.getUserWeight,
                    userProvider.getUserHeight,
                    userProvider.getUserAge,
                    userProvider.getUserActivity,
                    userProvider.getUserGoal),
                0)
            .toInt();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Container(
            height: 90.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 4, right: 16),
              child: StreamBuilder(
                  stream: bloc.totalCalories,
                  builder: (context, AsyncSnapshot<double> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      child: Center(
                                        child: Text(
                                          'CALORIES',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          16,
                                      child: Center(
                                        child: Text(
                                          '${snapshot.data.toInt()} / $kcal',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0, vertical: 8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                16,
                                        child: LineProgress(
                                          calories: kcal,
                                          snapshotData: snapshot.data / kcal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        );
      });
    });
  }
}
