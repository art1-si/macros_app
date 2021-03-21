import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mcr/app.dart';
import 'package:mcr/logic/User_provider.dart';
import 'package:mcr/logic/setting_notifier.dart';
import 'package:mcr/logic/theme_menager.dart';
import 'package:mcr/models/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  debugPaintSizeEnabled = false;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? true;
    var userHeight = prefs.getDouble('userHeight') ?? 183;
    var isUnitHightCm = prefs.getBool('isHeightUnitCm') ?? true;
    var userWeight = prefs.getDouble('userWeight') ?? 165;
    var isUnitWeightKg = prefs.getBool('isWeightUnitKg') ?? true;
    var userGender = prefs.getString('userGender') ?? "Male";
    var userAge = prefs.getInt('userAge') ?? 25;
    var userActivity = prefs.getString('userActivity') ?? "Moderately Active";
    var userGoal = prefs.getString('userGoal') ?? "Maintain";
    var heightUnit = prefs.getString('heightUnit') ?? 'cm';
    var weightUnit = prefs.getString('weightUnit') ?? 'lbs';
    runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<SettingNotifier>(
          create: (_) => SettingNotifier(weightUnit, heightUnit),
        ),
        ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme)),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(userHeight, isUnitHightCm, userWeight,
              isUnitWeightKg, userGender, userAge, userActivity, userGoal),
        )
      ], child: MyApp()),
    );
  });
}
