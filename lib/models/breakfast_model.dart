class BreakfastModel{

  int _id;
  String _breakfastProductName;
  String _brand;
  String _type;
  double _breakfastPrices;
  double _breakfastSize;
  double _breakfastFat;
  double _breakfastCarbs;
  double _breakfastProtein;
  double _breakfastCalories;
  String _breakfastDateCreated;

  BreakfastModel(

    
    this._breakfastProductName,
    this._brand,
    this._type,
    this._breakfastPrices,
    this._breakfastSize,
    this._breakfastFat,
    this._breakfastCarbs,
    this._breakfastProtein,
    this._breakfastCalories,
    this._breakfastDateCreated,

  );

  int get id => _id;
  String get breakfastProductName => _breakfastProductName;
  String get brand => _brand;
  String get type => _type;
  double get breakfastPrices => _breakfastPrices.toDouble();
  double get breakfastSize => _breakfastSize.toDouble();
  double get breakfastFat => _breakfastFat.toDouble();
  double get breakfastCarbs => _breakfastCarbs.toDouble();
  double get breakfastProtein => _breakfastProtein.toDouble();
  double get breakfastCalories => _breakfastCalories.toDouble();
  String get breakfastDateCreated => _breakfastDateCreated;

  BreakfastModel.map(dynamic obj){

    this._id = obj["id"];
    this._breakfastProductName = obj["name"];
    this._brand = obj["brand"];
    this._type = obj["type"];
    this._breakfastPrices = obj["price"].toDouble();
    this._breakfastSize = obj["size"].toDouble();
    this._breakfastFat = obj["fat"].toDouble();
    this._breakfastCarbs = obj["carbs"].toDouble();
    this._breakfastProtein = obj["protein"].toDouble();
    this._breakfastCalories = obj["calories"].toDouble();
    this._breakfastDateCreated = obj["dateCreated"];

  }

  Map<String, dynamic> toMap()=>{
    
    'id': id,
    'name': breakfastProductName,
    'brand':brand,
    'type': type,
    'price': breakfastPrices.toDouble(),
    'size': breakfastSize.toDouble(),
    'fat':breakfastFat.toDouble(),
    'carbs': breakfastCarbs.toDouble(),
    'protein':breakfastProtein.toDouble(),
    'calories':breakfastCalories.toDouble(),
    'dateCreated': breakfastDateCreated,
    
  };

  BreakfastModel.fromMap(Map<String, dynamic>data){

    this._id = data["id"];
    this._breakfastProductName = data["name"];
    this._brand = data["brand"];
    this._type = data["type"];
    this._breakfastPrices = data["price"].toDouble();
    this._breakfastSize = data["size"].toDouble();
    this._breakfastFat = data["fat"].toDouble();
    this._breakfastCarbs = data["carbs"].toDouble();
    this._breakfastProtein = data["protein"].toDouble();
    this._breakfastCalories = data["calories"].toDouble();
    this._breakfastDateCreated = data["dateCreated"];

  }

}