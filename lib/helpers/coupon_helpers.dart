import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../globals/globals.dart';
import '../models/product.dart';

class CouponDBHelper {
  CouponDBHelper._();

  static final CouponDBHelper couponDBHelper = CouponDBHelper._();

  final String dbName = "coupon.db";
  final String tableName = "coupons";
  final String colId = "id";
  final String colCoupon = "coupon";
  final String colQuantity = "Quantity";
  final String colPrice = "Price";

  Database? db;

  Future<void> initDB() async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbName);

    db = await openDatabase(path, version: 1, onCreate: (db, version) {});

    await db?.execute(
        "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colCoupon TEXT, $colQuantity INTEGER, $colPrice INTEGER);");
  }

  insertRecord() async {
    await initDB();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isInserted = prefs.getBool(tableName) ?? false;

    if (isInserted == false) {
      for (int i = 0; i < Global.coupon.length; i++) {
        Coupon data = Coupon.data(data: Global.coupon[i]);
        List args = [data.name, data.quantity, data.price];

        String query =
            "INSERT INTO $tableName($colCoupon, $colQuantity, $colPrice) VALUES(?, ?, ?)";

        await db?.rawInsert(query, args);
      }
      prefs.setBool(tableName, true);
    }
  }

  Future fetchAllRecords() async {
    await insertRecord();

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> allCoupon = await db!.rawQuery(query);

    List<CouponDB> couponList =
        allCoupon.map((e) => CouponDB.data(data: e)).toList();

    return couponList;
  }

  updateRecord({required int id, required int quantity}) async {
    await initDB();

    int? a = await db?.rawUpdate(
        "Update $tableName SET $colQuantity= ? WHERE $colId = ?",
        [--quantity, id]);

    print(a);
  }
}
