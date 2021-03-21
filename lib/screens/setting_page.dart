import 'package:flutter/material.dart';
import 'package:mcr/logic/setting_notifier.dart';
import 'package:mcr/logic/theme_menager.dart';
import 'package:mcr/models/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var _darkTheme = true;
  String dropdownWeightUnitValue = "kg";
  String dropdownHeightUnitValue = "cm";
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final settingNotifier =
        Provider.of<SettingNotifier>(context, listen: false);
    dropdownHeightUnitValue = settingNotifier.getHeightUnit();
    dropdownWeightUnitValue = settingNotifier.getWeightUnit();
    //final weightUnitNotifier = Provider.of<WeightUnitNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text("Setting Page",
              style: Theme.of(context).textTheme.headline6),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Dark Theme",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Switch(
                      value: _darkTheme,
                      onChanged: (bool newValue) {
                        setState(() {
                          _darkTheme = newValue;
                        });
                        onThemeChanged(newValue, themeNotifier);
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Weight Unit",
                      style: Theme.of(context).textTheme.bodyText1),
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
                    value: dropdownWeightUnitValue,
                    style: Theme.of(context).textTheme.bodyText1,
                    dropdownColor: Theme.of(context).primaryColor,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownWeightUnitValue = newValue;
                      });
                      settingNotifier.setWeightUnit(newValue);
                    },
                    items: <String>['kg', 'lbs']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Height Unit",
                      style: Theme.of(context).textTheme.bodyText1),
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
                    value: dropdownHeightUnitValue,
                    style: Theme.of(context).textTheme.bodyText1,
                    dropdownColor: Theme.of(context).primaryColor,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownHeightUnitValue = newValue;
                      });
                      settingNotifier.setHeightUnit(newValue);
                    },
                    items: <String>['cm', 'inches']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}
