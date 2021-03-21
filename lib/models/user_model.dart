class UserModel{

  int _id;
  double _userHeight;
  double _userWeight;
  String _userGender;
  int _userAge;
  String _userActivity;
  String _userGoal;

  UserModel(

    
    this._userHeight,
    this._userWeight,
    this._userGender,
    this._userAge,
    this._userActivity,
    this._userGoal,

  );

  int get id => _id;
  double get userHeight => _userHeight.toDouble();
  double get userWeight => _userWeight.toDouble();
  String get userGender => _userGender;
  int get userAge => _userAge;
  String get userActivity => _userActivity;
  String get userGoal => _userGoal;

  UserModel.map(dynamic obj){

    this._id = obj["id"];
    this._userHeight = obj["height"].toDouble();
    this._userWeight = obj["weight"].toDouble();
    this._userGender = obj["gender"];
    this._userAge = obj["age"];
    this._userActivity = obj["activity"];
    this._userGoal = obj["goal"];

  }

  Map<String, dynamic> toMap()=>{
    
    'id': id,
    'height': userHeight.toDouble(),
    'weight':userWeight.toDouble(),
    'gender': userGender,
    'age':userAge,
    'activity': userActivity,
    'goal':userGoal,
    
  };

  UserModel.fromMap(Map<String, dynamic>data){

    this._id = data["id"];
    this._userHeight = data["height"].toDouble();
    this._userWeight = data["weight"].toDouble();
    this._userGender = data["gender"];
    this._userAge = data["age"];
    this._userActivity = data["activity"];
    this._userGoal = data["goal"];

  }

}