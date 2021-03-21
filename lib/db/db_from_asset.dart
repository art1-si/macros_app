import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';


class GettingCopyDb{
 // final database4 = DatabaseHelper();

  static  Database _db;

  Future<Database> get db async{
      _db = await  _copyDatabase();
      return _db;
    }


  _copyDatabase()async{
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "bb.db");

    // delete existing if any
    await deleteDatabase(path);

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "bb.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes, flush: true);

    // open the database
    var ourdb = await openDatabase(path, readOnly: true);

    return ourdb;
  }

  Future<List> getProducts()async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM prod ORDER BY name ASC");
    return result.toList();
  }
}

/*void _handleSubmitted(name,brand,price,size,fat,carbs,protein)async{
    
    ProductModel noDoItem = ProductModel(name,brand,price.toDouble(),size,fat.toDouble(),carbs.toDouble(),protein.toDouble(),dateFormatted());
    int savedProductId = await database4.saveProduct(noDoItem);

    ProductModel addedProduct = await database4.getProduct(savedProductId);

    setState((){
      _productList.insert(0, addedProduct);
      print("Item saved id:$savedProductId");
    });
  }*/
