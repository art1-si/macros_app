import 'package:flutter/Material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingNotifier extends ChangeNotifier{
  String _weightUnit;
  String _heightUnit;
  SettingNotifier(this._weightUnit,this._heightUnit);

  getWeightUnit() => _weightUnit;
  getHeightUnit() => _heightUnit;

  setWeightUnit(String weightUnitNotifier)async{
    _weightUnit = weightUnitNotifier;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("weightUnit", weightUnitNotifier);
    notifyListeners();
  }
  setHeightUnit(String heightUnitNotifier)async{
    _heightUnit = heightUnitNotifier;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("heightUnit", heightUnitNotifier);
    notifyListeners();
  }
}