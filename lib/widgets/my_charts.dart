import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:mcr/bloc/bloc_meals.dart';
import 'package:mcr/logic/User_provider.dart';
import 'package:mcr/logic/date_formatter.dart';
import 'package:mcr/logic/day_selector_model.dart';
import 'package:mcr/logic/tdee_provider.dart';
import 'package:mcr/models/colors.dart';
import 'package:mcr/models/total_model.dart';

import 'package:provider/provider.dart';

class MyCharts extends StatefulWidget {
  @override
  _MyChartsState createState() => _MyChartsState();
}

final bloc = MealsBloc();

class _MyChartsState extends State<MyCharts>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<DaySelectorModel>(builder: (context, dateSe, child) {
        bloc.addFatToStream(
            '%${dateSe.daySelected.day}-0${dateSe.daySelected.month}-${dateSe.daySelected.year}%');
        return Consumer<UserProvider>(builder: (context, userProvider, child) {
          double proteinGoal;
          double fatGoal;
          double carbsGoal;
          double kcalGoal;
          kcalGoal = goalCalculator(
              userProvider.getUserGender,
              userProvider.getUserWeight,
              userProvider.getUserHeight,
              userProvider.getUserAge,
              userProvider.getUserActivity,
              userProvider.getUserGoal);
          proteinGoal = userProvider.getUserWeight;
          fatGoal = roundDouble((((kcalGoal) * (25 / 100)) / 9), 1);
          carbsGoal = ((kcalGoal - (proteinGoal * 4) - (fatGoal * 9)) / 4);
          return StreamBuilder(
              stream: bloc.totalMacros,
              builder: (context, AsyncSnapshot<TotalMacroModel> snapshot) {
                if (!snapshot.hasData) {
                  return Text("NO DATA");
                }
                return Column(
                  //shrinkWrap: true,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 6, right: 6, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: MediaQuery.of(context).size.height / 1.7,
                        child: CustomPaint(
                          painter: ShapePainter(
                            fatprogressIndicator:
                                (snapshot.data.totalFats / fatGoal >= 1)
                                    ? 1
                                    : snapshot.data.totalFats / fatGoal,
                            carbsprogressIndicator:
                                (snapshot.data.totalCarbs / carbsGoal >= 1)
                                    ? 1
                                    : snapshot.data.totalCarbs / carbsGoal,
                            proteinprogressIndicator:
                                (snapshot.data.totalProtein / proteinGoal >= 1)
                                    ? 1
                                    : snapshot.data.totalProtein / proteinGoal,
                            caloriesprogressIndicator:
                                (snapshot.data.totalCalories / kcalGoal >= 1)
                                    ? 1
                                    : snapshot.data.totalCalories / kcalGoal,
                            caloriesColor: Theme.of(context).accentColor,
                            fatColor: fatIdicatorColor,
                            carbsColor: carbsIdicatorColor,
                            proteinColor: proteinIdicatorColor,
                          ),
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 85),
                                child: Container(
                                  //color: Colors.blueAccent,
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              "Calories",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            ),
                                          ),
                                          Container(
                                            height: 7,
                                            width: 7,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${(snapshot.data.totalCalories / kcalGoal * 100).toInt()}%",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              "Fat",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            ),
                                          ),
                                          Container(
                                            height: 7,
                                            width: 7,
                                            decoration: BoxDecoration(
                                                color: fatIdicatorColor,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${(snapshot.data.totalFats / fatGoal * 100).toInt()}%",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              "Carbs",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            ),
                                          ),
                                          Container(
                                            height: 7,
                                            width: 7,
                                            decoration: BoxDecoration(
                                                color: carbsIdicatorColor,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${(snapshot.data.totalCarbs / carbsGoal * 100).toInt()}%",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              "Protein",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            ),
                                          ),
                                          Container(
                                            height: 7,
                                            width: 7,
                                            decoration: BoxDecoration(
                                                color: proteinIdicatorColor,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${(snapshot.data.totalProtein / proteinGoal * 100).toInt()}%",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                );
              });
        });
      }),
    );
  }
}

class ShapePainter extends CustomPainter {
  final double fatprogressIndicator;
  final double carbsprogressIndicator;
  final double proteinprogressIndicator;
  final double caloriesprogressIndicator;
  final Color caloriesColor;
  final Color fatColor;
  final Color carbsColor;
  final Color proteinColor;
  ShapePainter(
      {this.caloriesColor,
      this.fatColor,
      this.carbsColor,
      this.proteinColor,
      this.fatprogressIndicator,
      this.carbsprogressIndicator,
      this.proteinprogressIndicator,
      this.caloriesprogressIndicator});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(15.0, 25.0, size.width - 15, size.width + 5);
    final startAngle = math.pi;
    final sweepAngle = math.pi;
    final useCenter = false;
    final paint = Paint()
      ..color = Color(0xff091118).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    final paintProgress = Paint()
      ..color = fatColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    final paintProgressDot = Paint()
      ..color = fatColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    final paintProgress2 = Paint()
      ..color = carbsColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    final paintProgressDot2 = Paint()
      ..color = carbsColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    final paintProgress3 = Paint()
      ..color = proteinColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    final paintProgressDot3 = Paint()
      ..color = proteinColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;
    final paint4 = Paint()
      ..color = Color(0xff091118).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    final paintProgress4 = Paint()
      ..color = caloriesColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    final paintProgressDot4 = Paint()
      ..color = caloriesColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    canvas.drawArc(rect, startAngle / 1.4, sweepAngle / 2.1, useCenter, paint);
    canvas.drawArc(rect, startAngle / 1.4,
        ((sweepAngle / 2.1) * fatprogressIndicator), useCenter, paintProgress);
    canvas.drawArc(
        rect,
        (startAngle / 1.4) + (sweepAngle / 2.1) * fatprogressIndicator,
        0.001,
        useCenter,
        paintProgressDot);

    canvas.drawArc(rect, startAngle * 1.25, sweepAngle / 2.1, useCenter, paint);
    canvas.drawArc(rect, startAngle * 1.25,
        (sweepAngle / 2.1) * carbsprogressIndicator, useCenter, paintProgress2);
    canvas.drawArc(
        rect,
        (startAngle * 1.25) + (sweepAngle / 2.1) * carbsprogressIndicator,
        0.001,
        useCenter,
        paintProgressDot2);

    canvas.drawArc(rect, startAngle * 1.8, sweepAngle / 2.1, useCenter, paint);
    canvas.drawArc(
        rect,
        startAngle * 1.8,
        (sweepAngle / 2.1) * proteinprogressIndicator,
        useCenter,
        paintProgress3);
    canvas.drawArc(
        rect,
        (startAngle * 1.8) + (sweepAngle / 2.1) * proteinprogressIndicator,
        0.001,
        useCenter,
        paintProgressDot3);

    canvas.drawArc(
        Rect.fromLTRB(
            15.0 + 25, 25.0 + 25, size.width - 15 - 25, size.width + 5 - 25),
        -startAngle * 1.25,
        sweepAngle * 1.5,
        useCenter,
        paint4);
    canvas.drawArc(
        Rect.fromLTRB(
            15.0 + 25, 25.0 + 25, size.width - 15 - 25, size.width + 5 - 25),
        -startAngle * 1.25,
        (sweepAngle * 1.5 * caloriesprogressIndicator),
        useCenter,
        paintProgress4);
    canvas.drawArc(
        Rect.fromLTRB(
            15.0 + 25, 25.0 + 25, size.width - 15 - 25, size.width + 5 - 25),
        ((-startAngle * 1.25) + sweepAngle * 1.5 * caloriesprogressIndicator),
        (0.001),
        useCenter,
        paintProgressDot4);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
