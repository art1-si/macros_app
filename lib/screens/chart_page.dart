import 'package:flutter/material.dart';
import 'package:mcr/bloc/bloc_meals.dart';

import 'package:mcr/logic/day_selector_model.dart';
import 'package:mcr/widgets/my_charts.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatefulWidget {
  final int setFromFirstScreen;
  ChartPage({this.setFromFirstScreen});
  @override
  _ChartPageState createState() => _ChartPageState();
}

final bloc = MealsBloc();

class _ChartPageState extends State<ChartPage> {
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
          child: MyCharts(),
        ),
      ),
    );
  }
}
