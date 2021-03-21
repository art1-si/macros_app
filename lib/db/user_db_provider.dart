import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mcr/models/user_model.dart';

class UserDatabase{
  static final UserDatabase _instance = UserDatabase.internal();
  factory UserDatabase() => _instance;

  static Database _db;

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  UserDatabase.internal();

  initDb() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "user_db.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: breakfastDb);
    return ourDb;
  }


  

  void breakfastDb(Database database, int version)async{
    await database.execute("""
    CREATE TABLE user
    (
      id INTEGER PRIMARY KEY,
      height INTEGER,
      weight INTEGER,
      gender TEXT,
      age INTEGER,
      activity TEXT,
      goal TEXT
    )
    """);
  }

  Future<int> saveTotal(UserModel userModel)async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM user");
    if(result.isNotEmpty){
      print("dbClient != null");
      print("userModel.userGoal ${userModel.id}");
      UserModel newUserModel = UserModel.fromMap({
        "id" : 1,
        'height': userModel.userHeight,
        'weight':userModel.userWeight,
        'gender': userModel.userGender,
        'age':userModel.userAge,
        'activity': userModel.userActivity,
        'goal':userModel.userGoal
      });
      var res = await dbClient.update("user", newUserModel.toMap(),
        where: "id = ?", whereArgs: [1]);
      return res;  
        
    }else{
      print("dbClient == null");
      var res = await dbClient.insert("user", userModel.toMap());
      return res;
    }
    

  }
  Future<List> getTotalsFromDb()async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM user");
    return result.toList();
  }

  Future<int> getCount()async{
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery("SELECT COUNT(*) FROM user"));

  }

  Future<UserModel> getTotalFromDb(int id) async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM user WHERE id = $id");
    if (result.length == 0) return null;
    return UserModel.fromMap(result.first);
  }
  Future<int> deleteTotal(int id)async{
    var dbClient = await db;
    return await dbClient.delete("user", where: "id = ?",whereArgs:[id]);

  }

  Future<int> updateItem(UserModel userModel) async {
    var dbClient = await db;
    return await dbClient.update("user", userModel.toMap(),
        where: "id = ?", whereArgs: [userModel.id]);

  }
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

}
