import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mcr/db/db_from_asset.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mcr/models/product_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  var assetDb = GettingCopyDb();
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
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
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes, flush: true);

    // open the database
    var ourdb = await openDatabase(path, readOnly: false);

    return ourdb;
  }

  void productDb(Database database, int version) async {
    await database.execute("""
    CREATE TABLE Products
    (
      id INTEGER PRIMARY KEY,
      name TEXT,
      brand TEXT,
      price INTEGER,
      size INTEGER,
      unit TEXT,
      fat100 INTEGER,
      carbs100 INTEGER,
      protein100 INTEGER,
      dateCreated TEXT,
      uses INTEGER,
      servingSize INTEGER,
      lastServingSize INTEGER

    )
    """);
  }

  Future<int> saveProduct(ProductModel productModel) async {
    var dbClient = await db;
    int res = await dbClient.insert("Products", productModel.toMap());
    return res;
  }

  Future<List> getProducts() async {
    var dbClient = await db;

    print("is NOT adding assets db");
    var result =
        await dbClient.rawQuery("SELECT * FROM Products ORDER BY uses DESC");
    if (result.isEmpty) {
      print("is adding assets db");
      List assetproducts = await assetDb.getProducts();
      assetproducts.forEach((product) {
        saveProduct(ProductModel.map(product));
      });
    }
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM Products"));
  }

  Future<ProductModel> getProduct(int id) async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT * FROM Products WHERE id = $id");
    if (result.length == 0) return null;
    return ProductModel.fromMap(result.first);
  }

  Future<int> deleteProduct(int id) async {
    var dbClient = await db;
    return await dbClient.delete("Products", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateItem(ProductModel productModel, int id) async {
    print("product update uses ${productModel.id} $id");
    var dbClient = await db;
    return await dbClient.update(
        "Products",
        {
          'uses': productModel.uses,
          'lastServingSize': productModel.lastServingSize
        },
        where: "id = ?",
        whereArgs: [id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
