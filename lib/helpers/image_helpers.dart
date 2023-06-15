import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ImageAPIHelper {
  ImageAPIHelper._();

  static final ImageAPIHelper imageAPIHelper = ImageAPIHelper._();

  Future<Uint8List?> getImage({required String productName, required String category}) async {
    http.Response response = await http.get(
        Uri.parse("https://source.unsplash.com/random/${1}?$productName,$category"));

    if (response.statusCode == 200) {
      Uint8List data = response.bodyBytes;
      return data;
    }
    return null;
  }
}