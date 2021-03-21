class ProductModel{
  int _id;
  String _productname;
  String _brand;
  double _prices;
  int _sizeg;
  String _unit;
  double _fat100;
  double _carbs100;
  double _protein100;
  String _dateCreated;
  int _uses;
  double _servingSize;
  double _lastServingSize;

  ProductModel(
    
    this._productname,
    this._brand,
    this._prices,
    this._sizeg,
    this._unit,
    this._fat100,
    this._carbs100,
    this._protein100,
    this._dateCreated,
    this._uses,
    this._servingSize,
    this._lastServingSize,
    
  );
  int get id => _id;
  String get productname => _productname;
  String get brand => _brand;
  double get prices => _prices.toDouble();
  int get sizeg => _sizeg;
  String get unit => _unit;
  double get fat100 => _fat100.toDouble();
  double get carbs100 => _carbs100.toDouble();
  double get protein100 => _protein100.toDouble();
  String get dateCreated => _dateCreated;
  int get uses => _uses;
  double get servingSize => _servingSize.toDouble();
  double get lastServingSize => _lastServingSize.toDouble();

  ProductModel.map(dynamic obj){
    this._id = obj["id"];
    this._productname = obj["name"];
    this._brand = obj["brand"];
    this._prices = obj["price"].toDouble();
    this._sizeg = obj["size"];
    this._unit = obj["unit"];
    this._fat100 = obj["fat100"].toDouble();
    this._carbs100 = obj["carbs100"].toDouble();
    this._protein100 = obj["protein100"].toDouble();
    this._dateCreated = obj["dateCreated"];
    this._uses = obj["uses"];
    this._servingSize = obj["servingSize"].toDouble();
    this._lastServingSize = obj["lastServingSize"].toDouble();
  }

  Map<String, dynamic> toMap()=>{
    
    'id': id,
    'name': productname,
    'brand': brand,
    'price': prices.toDouble(),
    'size': sizeg,
    'unit': unit,
    'fat100':fat100.toDouble(),
    'carbs100': carbs100.toDouble(),
    'protein100':protein100.toDouble(),
    'dateCreated': dateCreated,
    'uses': uses,
    'servingSize': servingSize.toDouble(),
    'lastServingSize': lastServingSize.toDouble(),
  };
ProductModel.fromMap(Map<String, dynamic> data){
    this._id = data['id'];
    this._productname = data['name'];
    this._brand = data['brand'];
    this._prices = data['price'].toDouble();
    this._sizeg = data['size'];
    this._unit = data["unit"];
    this._fat100 = data['fat100'].toDouble();
    this._carbs100 = data['carbs100'].toDouble();
    this._protein100 = data['protein100'].toDouble();
    this._dateCreated = data["dateCreated"];
    this._uses = data["uses"];
    this._servingSize = data["servingSize"].toDouble();
    this._lastServingSize = data["lastServingSize"].toDouble();
}
   


}

