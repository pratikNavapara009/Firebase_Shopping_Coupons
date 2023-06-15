import 'package:get/get.dart';

import '../models/product.dart';


class CartController extends GetxController {
  RxList addedProduct = [].obs;
  RxList productQuantity = [].obs;
  RxInt discount = 0.obs;
  RxString promo = "Promo Code".obs;

  addDiscount({required int data,required String text})
  {
    discount = data.obs;
    promo = text.obs;
  }

  removeDiscount({required int data,required String text})
  {
    discount = data.obs;
    promo = text.obs;
  }

  void addQuantity({required ProductDB productDB, required int index}) {
    productQuantity[index]++;
  }

  void removeQuantity({required ProductDB product, required int index}) {
    (productQuantity[index] > 1) ? productQuantity[index]-- : product;
  }

  RxInt get totalQuantity {
    RxInt totalQuantity = 0.obs;
    for (var element in productQuantity) {
      totalQuantity += element;
    }
    return totalQuantity;
  }

  RxInt get totalPrice {
    RxInt finalTotal = 0.obs;
    for (var element in addedProduct) {
      int indext = addedProduct.indexOf(element);
      finalTotal += element.price * productQuantity[indext];
    }
    return finalTotal -= - discount.value;
  }

  addProduct({required ProductDB productDB}) {
    addedProduct.add(productDB);
    productQuantity.add(1);
  }

  removeProduct({required ProductDB productDB, required int quantity}) {
    addedProduct.remove(productDB);
    productQuantity.remove(quantity);
  }
}