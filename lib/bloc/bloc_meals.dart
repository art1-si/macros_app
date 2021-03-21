import 'dart:async';
import 'package:mcr/db/breakfast_db_provider.dart';
import 'package:mcr/logic/day_selector_model.dart';
import 'package:mcr/models/breakfast_model.dart';
import 'package:mcr/models/total_model.dart';
import 'package:rxdart/rxdart.dart';

class MealsBloc  {
  final dSM = DaySelectorModel();
  BreakfastDatabase db = BreakfastDatabase();
  final dateSelector = DaySelectorModel(); 
  final  _mealList = BehaviorSubject<List<BreakfastModel>>();



  final _totalPrice = StreamController<double>.broadcast();
  final _totalFat = StreamController<double>.broadcast();
  final _totalCarbs = StreamController<double>.broadcast();
  final _totalProtein = StreamController<double>.broadcast();
  final _totalCalories = StreamController<double>.broadcast();
  final _totalMacros = StreamController<TotalMacroModel>.broadcast();

  Stream<List<BreakfastModel>> get mealList => _mealList.stream;
  StreamSink<List<BreakfastModel>> get toMealList => _mealList.sink;
  
  Stream<List<BreakfastModel>> get breakfastList => _mealList.stream.map<List<BreakfastModel>>((list) => list.where((item) => item.type == "breakfast").toList());

  Stream<List<BreakfastModel>> get lunchList => _mealList.stream.map<List<BreakfastModel>>((list) => list.where((item) => item.type == "lunch").toList());

  Stream<List<BreakfastModel>> get dinnerList => _mealList.stream.map<List<BreakfastModel>>((list) => list.where((item) => item.type == "dinner").toList());

  Stream<List<BreakfastModel>> get snackList => _mealList.stream.map<List<BreakfastModel>>((list) => list.where((item) => item.type == "snack").toList());


  Stream<double> get totalPrice => _totalPrice.stream;
  StreamSink<double> get toTotalPrice => _totalPrice.sink;

  Stream<double> get totalFat => _totalFat.stream;
  StreamSink<double> get toTotalFat => _totalFat.sink;

  Stream<double> get totalCarbs => _totalCarbs.stream;
  StreamSink<double> get toTotalCarbs => _totalCarbs.sink;
  
  Stream<double> get totalProtein => _totalProtein.stream;
  StreamSink<double> get toTotalProtein => _totalProtein.sink;

  Stream<double> get totalCalories => _totalCalories.stream;
  StreamSink<double> get toTotalCalories => _totalCalories.sink;

  Stream<TotalMacroModel> get totalMacros => _totalMacros.stream;
  StreamSink<TotalMacroModel> get toTotalMacros => _totalMacros.sink;
  
  
  

  MealsBloc(){
    addMealsToStream('${dateSelector.daySelected.day}-0${dateSelector.daySelected.month}-${dateSelector.daySelected.year}');
    addFatToStream('${dateSelector.daySelected.day}-0${dateSelector.daySelected.month}-${dateSelector.daySelected.year}');
  }



  void addFatToStream(n)async{
    double price = 0;
    double fat = 0;
    double carbs = 0;
    double protein = 0;
    double calories = 0;
    List products = await db.getFats(n);
    products.forEach((product){
      price = price + product['price'];
      fat = fat + product['fat'];
      carbs = carbs + product['carbs'];
      protein = protein + product['protein'];
      calories = calories + product['calories'];
    
    });
    TotalMacroModel macroValue = TotalMacroModel(calories,fat,carbs,protein);
    toTotalMacros.add(macroValue);
    toTotalPrice.add(price);
    toTotalFat.add(fat);
    toTotalCarbs.add(carbs);
    toTotalProtein.add(protein);
    toTotalCalories.add(calories);
  }

  void addMealsToStream(n)async{
    List<BreakfastModel> b = <BreakfastModel>[];
    List products = await db.getMeals(n);
    products.forEach((product){

      b.add(BreakfastModel.map(product));
    });
    toMealList.add(b);
    
  }


  void dispose(){
    _mealList.close();
    _totalMacros.close();
    //_breakfastList.close();
    //_lunchList.close();
   // _dinnerList.close();
   //_snackList.close();
    _totalFat.close();
    _totalPrice.close();
    _totalCarbs.close();
    _totalProtein.close();
    _totalCalories.close();
  }
}