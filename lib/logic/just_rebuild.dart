import 'package:flutter/cupertino.dart';

class JustRebuild extends ChangeNotifier{

  double weight;
  void justrebuild(i){
    weight = i;
    notifyListeners();
  }
}