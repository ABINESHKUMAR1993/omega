import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:omiga_ipl/constants/constants.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/user_data.dart';
import 'package:omiga_ipl/models/order_place_model.dart';
import 'package:omiga_ipl/views/widgets/snack_bar.dart';

class CheckoutController extends GetxController {
  TextEditingController instructionController = TextEditingController();

  Future<void> placeOrder(OrderPlaceModel orderData, String instruction) async {
    try {
      final Map<String, dynamic> checkoutData = {
        "cart_items": orderData.data.cartItems.map((item) {
          return {
            "product_id": item.productDetailsId,
            "quantity": item.quantity,
            "variant_id": item.variantId,
          };
        }).toList(),
        "instruction": instruction,
      };

      final response = await http.post(
        Uri.parse(Urls.placeOrder),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken",
          "x-api-key": apiKey
        },
        body: jsonEncode(checkoutData),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.offNamed(sucScreen);
      } else {
        GetXSnackBar.show(
            data["status"].toString(), data["message"].toString(), true);
      }
    } catch (e) {
      GetXSnackBar.show("Error", e.toString(), true);
    }
  }
}
