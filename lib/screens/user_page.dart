import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcr/bloc/bloc_user.dart';
import 'package:mcr/logic/User_provider.dart';
import 'package:mcr/logic/date_formatter.dart';
import 'package:mcr/logic/setting_notifier.dart';
import 'package:mcr/logic/tdee_provider.dart';
import 'package:mcr/screens/setting_page.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String dropdownGenderValue = 'Male';
  String dropdownActivityValue = 'Moderately Active';
  String dropDownGoalValue = 'Maintain';

  final userBloc = UserBloc();
  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingNotifier>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final TextEditingController _heightTextEditingController =
        TextEditingController(text: userProvider.getUserHeight.toString());
    final TextEditingController _weightTextEditingController =
        TextEditingController(
            text: ((settingProvider.getWeightUnit() == "kg")
                    ? roundDouble(userProvider.getUserWeight / 2.2, 1)
                    : roundDouble(userProvider.getUserWeight, 1))
                .toString());
    final TextEditingController _ageTextEditingController =
        TextEditingController(text: userProvider.getUserAge.toString());
    dropdownGenderValue = userProvider.getUserGender;
    dropdownActivityValue = userProvider.getUserActivity;
    dropDownGoalValue = userProvider.getUserGoal;
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                child:
                    Icon(Icons.settings, color: Colors.white.withOpacity(0.46)),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage())),
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
            child: Text(
              'User Profil',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        body: Consumer<UserProvider>(builder: (context, userProvider, child) {
          print(userProvider);
          if (true) {
            double calBMR;
            double tdeeOfUser;
            double goalOfUser;
            tdeeOfUser = tdeeCalculator(
                userProvider.getUserGender,
                userProvider.getUserWeight,
                userProvider.getUserHeight,
                userProvider.getUserAge,
                userProvider.getUserActivity);
            goalOfUser = goalCalculator(
                userProvider.getUserGender,
                userProvider.getUserWeight,
                userProvider.getUserHeight,
                userProvider.getUserAge,
                userProvider.getUserActivity,
                userProvider.getUserGoal);
            calBMR = bmrCalculator(
                userProvider.getUserGender,
                userProvider.getUserWeight,
                userProvider.getUserHeight,
                userProvider.getUserAge,
                userProvider.getUserActivity);
            return ListView(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            child: Container(
                              height: 55.0,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                  width: 2,
                                )),
                                //borderRadius: new BorderRadius.only(topLeft:Radius.circular(20.0),topRight:Radius.circular(20.0),),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 7),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Profile',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: <Widget>[
                              Text("Height(${settingProvider.getHeightUnit()})",
                                  style: Theme.of(context).textTheme.subtitle2),
                              Expanded(
                                child: TextFormField(
                                  onChanged: (value) {
                                    userProvider
                                        .setUserHeight(double.parse(value));
                                    userProvider.setIsHeightUnitIsCm(
                                        settingProvider.getHeightUnit() ==
                                            "cm");
                                  },
                                  controller:
                                      _heightTextEditingController, // = "${userProvider.getUserHeight}",
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: <Widget>[
                              Text("Weight(${settingProvider.getWeightUnit()})",
                                  style: Theme.of(context).textTheme.subtitle2),
                              Expanded(
                                child: TextField(
                                  controller: _weightTextEditingController,
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    userProvider
                                        .setUserWeight(double.parse(value));
                                    userProvider.setIsWeightUnitIsKg(
                                        settingProvider.getWeightUnit() ==
                                            "kg");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Gender",
                                  style: Theme.of(context).textTheme.subtitle2),
                              DropdownButton<String>(
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: Theme.of(context).accentColor,
                                ),
                                underline: Container(
                                  height: 0,
                                  color: Color(0xff667AFF),
                                ),
                                elevation: 0,
                                value: dropdownGenderValue,
                                style: Theme.of(context).textTheme.bodyText1,
                                dropdownColor:
                                    Theme.of(context).primaryColorLight,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownGenderValue = newValue;
                                  });
                                  userProvider
                                      .setUserGender(dropdownGenderValue);
                                },
                                items: <String>['Male', 'Woman']
                                    .map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: <Widget>[
                              Text("Age",
                                  style: Theme.of(context).textTheme.subtitle2),
                              Expanded(
                                  child: TextField(
                                controller: _ageTextEditingController,
                                keyboardType: TextInputType.numberWithOptions(),
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  userProvider.setUserAge(int.parse(value));
                                },
                              )),
                            ],
                          ),
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Activity",
                                  style: Theme.of(context).textTheme.subtitle2),
                              DropdownButton<String>(
                                elevation: 0,
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: Theme.of(context).accentColor,
                                ),
                                underline: Container(
                                  height: 0,
                                  color: Color(0xff667AFF),
                                ),
                                value: dropdownActivityValue,
                                style: Theme.of(context).textTheme.bodyText1,
                                dropdownColor:
                                    Theme.of(context).primaryColorLight,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownActivityValue = newValue;
                                  });
                                  userProvider
                                      .setUserActivity(dropdownActivityValue);
                                },
                                items: <String>[
                                  'Sedentary',
                                  'Lightly Active',
                                  'Moderately Active',
                                  'Very Active',
                                  'Extremely Active'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Goal",
                                  style: Theme.of(context).textTheme.subtitle2),
                              DropdownButton<String>(
                                elevation: 0,
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: Theme.of(context).accentColor,
                                ),
                                value: dropDownGoalValue,
                                underline: Container(
                                  height: 0,
                                  color: Color(0xff667AFF),
                                ),
                                style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                ),
                                dropdownColor:
                                    Theme.of(context).primaryColorLight,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropDownGoalValue = newValue;
                                  });
                                  userProvider.setUserGoal(dropDownGoalValue);
                                },
                                items: <String>[
                                  'Fat Loss',
                                  'Maintain',
                                  'Weight Gain'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("BMR",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  Text("$calBMR",
                                      style:
                                          Theme.of(context).textTheme.bodyText1)
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 1,
                            height: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("TDEE",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  Text("$tdeeOfUser",
                                      style:
                                          Theme.of(context).textTheme.bodyText1)
                                ],
                              )),
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Goal Calories",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  Text("$goalOfUser",
                                      style:
                                          Theme.of(context).textTheme.bodyText1)
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
