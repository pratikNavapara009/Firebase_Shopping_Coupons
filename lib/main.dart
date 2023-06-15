import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shopping_app/contollers/voucher.dart';
import 'package:shopping_app/contollers/voucher_event.dart';
import 'package:shopping_app/screens/cart_page.dart';
import 'package:shopping_app/screens/coupons.dart';
import 'package:shopping_app/screens/coupons_page.dart';
import 'package:shopping_app/screens/homepage.dart';
import 'package:shopping_app/screens/product_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase/voucher_firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                VoucherBloc(voucherRepository: VoucherRepository())
                  ..add(LoadVouchers())),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => const HomePage()),
          GetPage(name: "/product_page", page: () => const ProductPage()),
          GetPage(name: "/cart_page", page: () => const CartPage()),
          GetPage(name: "/coupon", page: () => const CouponPage()),
          GetPage(name: "/coupon_page", page: () => VoucherScreen()),
        ],
      ),
    ),
  );
}
