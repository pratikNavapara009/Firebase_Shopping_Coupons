import 'package:flutter/material.dart';

import '../models/product.dart';


class Global {
  static String content =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
      "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.";

  static List<Coupon> coupon = [
    Coupon(name: "SUPER1000", quantity: 8, price: 1000),
    Coupon(name: "EPIC", quantity: 6, price: 400),
    Coupon(name: "LUCKY", quantity: 10, price: 199),
    Coupon(name: "LUCKY12", quantity: 0, price: 149),
  ];

  static List<Product> allProduct = [
    Product(
      name: "Laptop",
      details: content,
      category: "electronics",
      like: 1,
      price: 21999,
    ),
    Product(
      name: "smart watch",
      details: content,
      category: "electronics",
      like: 1,
      price: 2249,
    ),
    Product(
      name: "iphone",
      details: content,
      category: "electronics",
      like: 1,
      price: 9842,
    ),
    Product(
      name: "iphone 14",
      details: content,
      category: "electronics",
      like: 1,
      price: 12988,
    ),
    Product(
      name: "iphone 14",
      details: content,
      category: "electronics",
      like: 1,
      price: 12899,
    ),
    Product(
      name: "Refrigerator",
      details: content,
      category: "Electric",
      like: 1,
      price: 8999,
    ),
    Product(
      name: "Oven Toaster",
      details: content,
      category: "electronics",
      like: 1,
      price: 1365,
    ),
    Product(
      name: "Fan",
      details: content,
      category: "Electric",
      like: 1,
      price: 2589,
    ),
  ];

  static snackBar({required BuildContext context,
    required String message,
    required Color color,
    required IconData icon}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              message,
            ),
          ],
        ),
      ),
    );
  }
}