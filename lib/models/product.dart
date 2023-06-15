import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final String category;
  final String details;
  final int like;
  final int price;
  Uint8List? image;

  Product({
    required this.name,
    required this.details,
    required this.category,
    required this.like,
    required this.price,
    this.image,
  });

  factory Product.fromData({required Product data, Uint8List? image}) {
    return Product(
        name: data.name,
        details: data.details,
        category: data.category,
        like: data.like,
        price: data.price,
        image: image);
  }
}

class ProductDB {
  final String name;
  final String category;
  final String details;
  final int like;
  final int price;
  final Uint8List image;
  final int id;

  ProductDB(
      {required this.name,
        required this.details,
        required this.category,
        required this.like,
        required this.price,
        required this.image,
        required this.id});

  factory ProductDB.fromData({required Map data}) {
    return ProductDB(
      name: data["Name"],
      details: data["Details"],
      category: data["Category"],
      like: data["likes"],
      price: data["Price"],
      image: data["Image"],
      id: data["Id"],
    );
  }
}

class Coupon
{
  final String name;
  final int quantity;
  final int price;

  Coupon({required this.name, required this.quantity, required this.price});

  factory Coupon.data({required Coupon data}){
    return Coupon(name: data.name, quantity: data.quantity, price: data.price);
  }
}

class CouponDB
{
  final String name;
  final int quantity;
  final int price;

  CouponDB({required this.name, required this.quantity, required this.price});

  factory CouponDB.data({required Map data}){
    return CouponDB(name: data["coupon"], quantity: data["Quantity"], price: data["Price"]);
  }
}