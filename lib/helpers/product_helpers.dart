import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../globals/globals.dart';
import '../models/product.dart';
import 'image_helpers.dart';


class ProductDBHelper {
  ProductDBHelper._();

  static final ProductDBHelper productDBHelper = ProductDBHelper._();

  final String databaseName = "shopping.db";
  final String tableName = "product";
  final String colId = "Id";
  final String colName = "Name";
  final String colDetails = "Details";
  final String colCategory = "Category";
  final String colLike = "likes";
  final String colPrice = "Price";
  final String colImage = "Image";

  Database? database;

  Future<void> initDB() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, databaseName);

    database = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
          await database.execute(
              "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colCategory TEXT, $colDetails TEXT, $colLike INTEGER, $colPrice INTEGER, $colImage BLOB);");
        });
  }

  Future<void> insertRecord() async {
    await initDB();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isInserted = prefs.getBool(tableName) ?? false;

    if (isInserted == false) {
      for (int i = 0; i < Global.allProduct.length; i++) {
        Uint8List? imageData = await ImageAPIHelper.imageAPIHelper.getImage(
            productName: Global.allProduct[i].name,
            category: Global.allProduct[i].category);
        Product data =
        Product.fromData(data: Global.allProduct[i], image: imageData);

        String query =
            "INSERT INTO $tableName($colName, $colCategory, $colDetails, $colLike, $colPrice, $colImage) VALUES(?, ?, ?, ?, ?, ?);";
        List args = [
          data.name,
          data.category,
          data.details,
          data.like,
          data.price,
          data.image,
        ];
        await database!.rawInsert(query, args);
      }
      prefs.setBool(tableName, true);
    }
  }

  Future<List<ProductDB>> getAllRecode() async {
    await insertRecord();

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> data = await database!.rawQuery(query);

    List<ProductDB> productDB =
    data.map((e) => ProductDB.fromData(data: e)).toList();
    return productDB;
  }
}