import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../contollers/controllers.dart';
import '../globals/globals.dart';
import '../helpers/coupon_helpers.dart';
import '../models/product.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {

  CartController cartController = Get.find<CartController>();

  Future? getData;

  @override
  void initState() {
    getData = CouponDBHelper.couponDBHelper.fetchAllRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apply coupon"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder(
        future: getData,
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("Error : ${snapShot.error}"),
              ),
            );
          } else if (snapShot.hasData) {
            List<CouponDB> data = snapShot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) => Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data[i].name,
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "₹ ${data[i].price}",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "We display shipping speeds and charges based on the items in your cart and the delivery address. ${data[i].quantity} ",
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                  trailing: OutlinedButton(
                      onPressed: () async {
                        if (data[i].quantity > 0) {
                          CouponDBHelper.couponDBHelper
                              .updateRecord(id: i, quantity: data[i].quantity);
                          cartController.addDiscount(
                              data: data[i].price, text: data[i].name);
                          await getData;
                          Global.snackBar(
                              context: context,
                              message: "Coupon Apply Successfully",
                              color: Colors.green,
                              icon: Icons.confirmation_num_outlined);
                          await getData;
                          Get.back();
                        } else {
                          cartController.removeDiscount(
                              data: 0, text: "Promo Code");
                          Global.snackBar(
                              context: context,
                              message: "Coupon is Not available",
                              color: Colors.red,
                              icon: Icons.access_alarm);
                        }
                      },
                      child: const Text("Apply")),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}