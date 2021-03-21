import 'dart:io';
import 'package:mcr/logic/day_selector_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mcr/models/breakfast_model.dart';

class BreakfastDatabase{
  static final BreakfastDatabase _instance = BreakfastDatabase.internal();
  factory BreakfastDatabase() => _instance;
  final dateSelector = DaySelectorModel();
  static Database _db;

  Future<Database> get db async{
    if(_db != null){

      return _db;
      
    }
    _db = await initDb();

    return _db;
    
  }

  BreakfastDatabase.internal();

  initDb() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "breakfast.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: breakfastDb);
    return ourDb;
  }


  

  void breakfastDb(Database database, int version)async{
    await database.execute("""
    CREATE TABLE breakfast
    (
      id INTEGER PRIMARY KEY,
      name TEXT,
      brand TEXT,
      type TEXT,
      price INTEGER,
      size INTEGER,
      fat INTEGER,
      carbs INTEGER,
      protein INTEGER,
      calories INTEGER,
      dateCreated String
    )
    """);
  }

  Future<int> saveMeal(BreakfastModel mealModel)async{
    var dbClient = await db;
    var res = await dbClient.insert("breakfast", mealModel.toMap());
    return res;
  }
  Future<List> getMeals(n)async{
    //String n = '${27}-0${dateSelector.daySelected.month}-${dateSelector.daySelected.year}';
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM breakfast WHERE dateCreated LIKE '%$n%' ORDER BY dateCreated DESC");
    return result.toList();
  }

  Future<int> getCount()async{
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery("SELECT COUNT(*) FROM breakfast"));

  }

  Future<BreakfastModel> getMeal(int id) async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM breakfast WHERE id = $id");
    if (result.length == 0) return null;
    return BreakfastModel.fromMap(result.first);
  }
  Future<List> getBreakfast(String n) async{
    
    print("getBreakfast $n");
   var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM breakfast WHERE type = 'breakfast'AND dateCreated LIKE '%$n%'");
    return result.toList();
  }
  Future<List> geLunch() async{
   var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM breakfast WHERE type='lunch' AND dateCreated LIKE '%${dateSelector.daySelected.day}-0${dateSelector.daySelected.month}-${dateSelector.daySelected.year}%'");
    return result.toList();
  }
  Future<List> geDinner() async{
   var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM breakfast WHERE type='dinner'AND dateCreated LIKE '%${dateSelector.daySelected.day}-0${dateSelector.daySelected.month}-${dateSelector.daySelected.year}%'");
    return result.toList();
  }
  Future<List> geSnack() async{
   var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM breakfast WHERE type='snack'AND dateCreated LIKE '%${dateSelector.daySelected.day}-0${dateSelector.daySelected.month}-${dateSelector.daySelected.year}%'");
    return result.toList();
  }
  Future<int> deleteMeal(int id)async{
    var dbClient = await db;
    return await dbClient.delete("breakfast", where: "id = ?",whereArgs:[id]);

  }

  Future<int> updateItem(BreakfastModel mealModel) async {
    var dbClient = await db;
    return await dbClient.update("breakfast", mealModel.toMap(),
        where: "id = ?", whereArgs: [mealModel.id]);

  }

    Future<List> getFats(n)async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT price,fat,carbs,protein,calories FROM breakfast WHERE dateCreated LIKE '%$n%'");
    return result.toList();
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

}
