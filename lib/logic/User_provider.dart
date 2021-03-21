import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  double _userHeight;
  bool _isCm;
  double _userWeight;
  bool _isKg;
  String _userGender;
  int _userAge;
  String _userActivity;
  String _userGoal;

  UserProvider(this._userHeight, this._isCm, this._userWeight, this._isKg,
      this._userGender, this._userAge, this._userActivity, this._userGoal);

  get getUserHeight => _userHeight;
  get getIsCm => _isCm;
  get getUserWeight => _userWeight;
  get getIsKg => _isKg;
  get getUserGender => _userGender;
  get getUserAge => _userAge;
  get getUserActivity => _userActivity;
  get getUserGoal => _userGoal;

  setUserHeight(double height) async {
    _userHeight = height;
    var prefs = await SharedPreferences.getInstance();
    prefs.setDouble('userHeight', height);
    notifyListeners();
  }

  setIsHeightUnitIsCm(bool isCm) async {
    _isCm = isCm;
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('isHeightUnitCm', isCm);
    notifyListeners();
  }

  setUserWeight(double weight) async {
    _userWeight = weight;
    var prefs = await SharedPreferences.getInstance();
    prefs.setDouble('userWeight', weight);
    notifyListeners();
  }

  setIsWeightUnitIsKg(bool isKg) async {
    _isCm = isKg;
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('isWeightUnitKg', isKg);
    notifyListeners();
  }

  setUserGender(String gender) async {
    _userGender = gender;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("userGender", gender);
    notifyListeners();
  }

  setUserAge(int age) async {
    _userAge = age;
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt("userAge", age);
    notifyListeners();
  }

  setUserActivity(String activity) async {
    _userActivity = activity;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("userActivity", activity);
    notifyListeners();
  }

  setUserGoal(String goal) async {
    _userGoal = goal;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("userGoal", goal);
    notifyListeners();
  }
}
