import 'package:flutter/cupertino.dart';

class TotalMacroProvider extends ChangeNotifier{
  double _totalCalories = 0;
  double _totalFat = 0;
  double _totalCarbs = 0;
  double _totalProtein = 0;

  TotalMacroProvider(this._totalCalories,this._totalFat,this._totalCarbs,this._totalProtein);

  get getCalories => _totalCalories;
  get getFats => _totalFat;
  get getCarbs => _totalCarbs;
  get getProtein => _totalProtein;

  setCalories(double newValue){
    _totalCalories = newValue;
    notifyListeners();
  }
  setFats(double newValue){
    _totalFat = newValue;
    notifyListeners();
  }
  setCarbs(double newValue){
    _totalCarbs = newValue;
    notifyListeners();
  }
  setProtein(double newValue){
    _totalProtein = newValue;
    notifyListeners();
  }
}