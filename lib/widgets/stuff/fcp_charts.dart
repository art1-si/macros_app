import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mcr/bloc/bloc_meals.dart';
import 'package:mcr/bloc/bloc_user.dart';
import 'package:mcr/logic/User_provider.dart';
import 'package:mcr/logic/day_selector_model.dart';
import 'package:mcr/logic/tdee_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';


class FcpCharts extends StatefulWidget {
  @override
  _FcpChartsState createState() => _FcpChartsState();
}

class _FcpChartsState extends State<FcpCharts> {
  final bloc = MealsBloc();
  final userBloc = UserBloc();

  double calfat(double userKcalGoal){
    return (userKcalGoal * 20/100)/9;
  }

  double roundDouble(double value, int places){ 
    double mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<DaySelectorModel>(
      builder:(context, dateSe, child){
        bloc.addFatToStream('%${dateSe.daySelected.day}-0${dateSe.daySelected.month}-${dateSe.daySelected.year}%');
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal:0.0),
          child: Container( 
              decoration: new BoxDecoration(
                //color: Color(0xff282F3D),
                borderRadius: new BorderRadius.only(
                  bottomRight:Radius.circular(0.0),),  
              ),
            //
            child: Padding(
              padding: const EdgeInsets.only(left:6.0,right: 10),
              child: Consumer<UserProvider>(
                builder: (context,userProvider,child){
                double proteinGoal;
                double fatGoal;
                double carbsGoal;
                double kcalGoal;
                kcalGoal = goalCalculator(userProvider.getUserGender,userProvider.getUserWeight, userProvider.getUserHeight, userProvider.getUserAge, userProvider.getUserActivity,userProvider.getUserGoal);
                proteinGoal = userProvider.getUserWeight * 2.2;
                fatGoal = roundDouble((((kcalGoal) * (25/100))/9),1);
                carbsGoal = ((kcalGoal -(proteinGoal * 4) - ((kcalGoal) * (25/100)))/4);
                  return Column(

                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: StreamBuilder(
                              stream: bloc.totalFat,
                              builder: (context, AsyncSnapshot<double>snapshot) {
                                if (!snapshot.hasData){
                                  return Container(
                                  child: Text(
                                    'Fats: 02',
                                    style: Theme.of(context).textTheme.headline3,
                                    )
                                  );
                                }
                                else{
                                  return Container(
                                    decoration: BoxDecoration( 
                                        borderRadius: BorderRadius.circular(10.0), 
                                        color: Theme.of(context).primaryColor,
                                      //borderRadius: new BorderRadius.only(topLeft:Radius.circular(20.0),topRight:Radius.circular(20.0),),  
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularPercentIndicator(
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        radius: screenWidth /2-35,
                                        lineWidth: 15.0,
                                        header: Text("Fat", style: Theme.of(context).textTheme.headline2,),
                                        percent: (snapshot.data/fatGoal >= 1) ? 1 : snapshot.data/fatGoal,
                                        center: Text("${snapshot.data.toInt()}", style: Theme.of(context).textTheme.headline2,),
                                        progressColor:(snapshot.data/fatGoal >= 1) ? Theme.of(context).errorColor : Color(0xffFFA55E),
                                        circularStrokeCap: CircularStrokeCap.square,
                                      ),
                                    ),
                                  );
                                } 
                              }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: StreamBuilder(
                              stream: bloc.totalCarbs,
                              builder: (context, AsyncSnapshot<double>snapshot) {
                                if (!snapshot.hasData){
                                  return Container(
                                  child: Text(
                                    'Carbss: 0',
                                    style: Theme.of(context).textTheme.headline3,
                                    )
                                  );
                                }
                                else{
                                  return Container(
                                    decoration: BoxDecoration( 
                                      borderRadius: BorderRadius.circular(10.0), 
                                      color: Theme.of(context).primaryColor,
                                    //borderRadius: new BorderRadius.only(topLeft:Radius.circular(20.0),topRight:Radius.circular(20.0),),  
                                  ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularPercentIndicator(
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        radius: screenWidth /2-35,
                                        lineWidth: 15.0,
                                        header: Text("Carbs", style: Theme.of(context).textTheme.headline2,),
                                        percent: (snapshot.data/carbsGoal >= 1) ? 1 : snapshot.data/carbsGoal,
                                        center: Text("${snapshot.data.toInt()}", style: Theme.of(context).textTheme.headline2,),
                                        progressColor:(snapshot.data/carbsGoal >= 1) ? Theme.of(context).errorColor : Color(0xffFEE05E ),
                                        circularStrokeCap: CircularStrokeCap.square,
                                      ),
                                    ),
                                  );
                                }
                                
                              }
                            ),
                          ),
                          
                         
                          
                      ],),
                    Row(
                      children: <Widget>[
                         Padding(
                            padding: const EdgeInsets.all(5),
                            child: StreamBuilder(
                              stream: bloc.totalProtein,
                              builder: (context, AsyncSnapshot<double>snapshot) {
                                if (!snapshot.hasData){
                                  return Container(
                                  child: Text(
                                    'Proteinss: 0',
                                    style:Theme.of(context).textTheme.headline3,
                                    )
                                  );
                                }
                                else{
                                  return Container(
                                    decoration: BoxDecoration( 
                                      borderRadius: BorderRadius.circular(10.0), 
                                      color: Theme.of(context).primaryColor,
                                    //borderRadius: new BorderRadius.only(topLeft:Radius.circular(20.0),topRight:Radius.circular(20.0),),  
                                  ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularPercentIndicator(
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        radius: screenWidth /2-35,
                                        lineWidth: 15.0,
                                        header: Text("Protein", style: Theme.of(context).textTheme.headline2,),
                                        percent: (snapshot.data/proteinGoal >= 1) ? 1 : snapshot.data/proteinGoal,
                                        center: Text("${snapshot.data.toInt()}", style: Theme.of(context).textTheme.headline2,),
                                        progressColor:(snapshot.data/proteinGoal >= 1) ? Theme.of(context).errorColor : Color(0xff3B4AAA),
                                        circularStrokeCap: CircularStrokeCap.square,
                                      ),
                                    ),
                                  );
                                }
                                
                              }
                            ),
                          ),
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: StreamBuilder(
                              stream: bloc.totalCalories,
                              builder: (context, AsyncSnapshot<double>snapshot) {
                                if (!snapshot.hasData){
                                  return Container(
                                  child: Text(
                                    'Proteinss: 0',
                                    style:Theme.of(context).textTheme.headline3,
                                    )
                                  );
                                }
                                else{
                                  return Container(
                                      decoration: BoxDecoration( 
                                        borderRadius: BorderRadius.circular(10.0), 
                                        color: Theme.of(context).primaryColor,
                                      //borderRadius: new BorderRadius.only(topLeft:Radius.circular(20.0),topRight:Radius.circular(20.0),),  
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularPercentIndicator(
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        radius: screenWidth /2-35,
                                        lineWidth: 15,
                                        header: Text("Calories", style: Theme.of(context).textTheme.headline2,),
                                        percent: (snapshot.data/kcalGoal >= 1) ? 1 : snapshot.data/kcalGoal,
                                        center: Text("${snapshot.data.toInt()}", style: Theme.of(context).textTheme.headline2,),
                                        progressColor:(snapshot.data/kcalGoal >= 1) ? Theme.of(context).errorColor : Theme.of(context).accentColor,
                                        circularStrokeCap: CircularStrokeCap.square,
                                      ),
                                    ),
                                  );
                                }
                                
                              }
                            ),
                          ),
                      ],
                    ),  
                    ],
                  );
                }
              ),
            ),
          ),
        );
      }
    );
  }
}