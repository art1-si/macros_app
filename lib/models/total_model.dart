class TotalMacroModel{
  double _totalCalories;
  double _totalFats;
  double _totalCarbs;
  double _totalProtein;

  TotalMacroModel(
    this._totalCalories,
    this._totalFats,
    this._totalCarbs,
    this._totalProtein,
  );

  double get totalCalories => _totalCalories;
  double get totalFats => _totalFats;
  double get totalCarbs => _totalCarbs;
  double get totalProtein => _totalProtein;

  TotalMacroModel.map(dynamic obj){
    this._totalCalories = obj["totalCalories"];
    this._totalFats = obj["totalFats"];
    this._totalCarbs = obj["totalCarbs"];
    this._totalProtein = obj["totalProtein"];
  }

  Map<String,dynamic>toMap() => {
    "totalCalories": totalCalories,   
    "totalFats":totalFats,
    "totalCarbs":totalCarbs,
    "totalProtein":totalProtein,
  };
  TotalMacroModel.fromMap(Map<String, dynamic>data){
    this._totalCalories = data["totalCalories"];
    this._totalFats = data["totalFats"];
    this._totalCarbs = data["totalCarbs"];
    this._totalProtein = data["totalProtein"];
  }

}