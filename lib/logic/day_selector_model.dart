import 'package:flutter/material.dart';

class DaySelectorModel extends ChangeNotifier{

  static DateTime now = DateTime.now();
  static DateTime yesteday = now.subtract(Duration(days: 1));
  static DateTime _tomorrow = now.add(Duration(days: 1));
  static DateTime lastMidnight = now.subtract(Duration(
    hours: now.hour,
    minutes: now.minute,
    seconds: now.second,
    milliseconds: now.millisecond,
    microseconds: now.microsecond,
  ));
  
  static int n = 0;
  DateTime _dateSelected = lastMidnight.add(Duration(days: n ?? 0));
  void daySelectorAdd()async{
    n++;
    _dateSelected = lastMidnight.add(Duration(days: n));
    _dateSelected.add(Duration(days: n));
    notifyListeners(); 
  }

    void daySelectorSub(){
    n--;
    _dateSelected = lastMidnight.add(Duration(days: n));
    _dateSelected.add(Duration(days: n));
    notifyListeners(); 
  }
  
  
  DateTime get daySelected => _dateSelected;
  DateTime get today => now;
  DateTime get yesterday => yesteday;
  DateTime get tomorrow => _tomorrow;
  void resetDate(){
    _dateSelected = lastMidnight.add(Duration(days: 0));
    _dateSelected.add(Duration(days: 0));
  }
  void justNotify(){
    notifyListeners(); 
  }
  

}