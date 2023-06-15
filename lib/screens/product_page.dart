import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../contollers/controllers.dart';
import '../models/product.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  CartController cartController = Get.find<CartController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductDB data = Get.arguments;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
        title: Text(
          "Order",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: carouselSlider(
                height: size.height,
                width: size.width,
                productName: data.name,
                category: data.category),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.name,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(CupertinoIcons.heart_fill,color: Colors.red,),
                      ),
                    ],
                  ),
                  Text(
                    data.category,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    data.details,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Review 12",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "⭐⭐⭐⭐ 4.1",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  const Spacer(),
                  Text(
                    "₹ ${data.price}",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: size.width,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                child: ElevatedButton(
                  onPressed: () {
                    cartController.addProduct(productDB: data);
                    Get.offNamed("/cart_page");
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)))
                  ),
                  child: Text("+ Add to Cart",style: GoogleFonts.poppins(fontSize: 18,color: Colors.white),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget carouselSlider(
      {required double height,
        required double width,
        required String productName,
        required String category}) {
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 4/3,
          autoPlay: true,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: List.generate(
          4,
              (index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                    "https://source.unsplash.com/random/${index + 1}?$productName,$category"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ).toList());
  }
}