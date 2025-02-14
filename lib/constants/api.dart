import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:omiga_ipl/constants/constants.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/user_data.dart';
import 'package:omiga_ipl/controllers/bottom_nav_controller.dart';
import 'package:omiga_ipl/models/address_model.dart';
import 'package:omiga_ipl/models/banner_model.dart';
import 'package:omiga_ipl/models/cart_model.dart';
import 'package:omiga_ipl/models/category_model.dart';
import 'package:omiga_ipl/models/fav_model.dart';
import 'package:omiga_ipl/models/notification_model.dart';
import 'package:omiga_ipl/models/order_detail_model.dart';
import 'package:omiga_ipl/models/order_place_model.dart';
import 'package:omiga_ipl/models/orders_model.dart';
import 'package:omiga_ipl/models/product_detail_model.dart';
import 'package:omiga_ipl/models/product_model.dart';
import 'package:omiga_ipl/models/sub_cat_model.dart';
import 'package:omiga_ipl/models/user_model.dart';
import 'package:omiga_ipl/views/widgets/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkHelper {
  // Authentication Apis<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  // SignUp......................

  Future signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String phnNumber,
    required String pwd,
    required String confirmPwd,
  }) async {
    http.Response? response;
    //The url is saved with endpoint in the Urls.register variable name
    response = await _postRequest(context: context, url: Urls.register, body: {
      //Add as needed parameter name accordingly
      "name": name,
      "email": email,
      "phone_number": phnNumber,
      "password": pwd,
      "password_confirmation": confirmPwd,
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint("Registered--------$data");
      GetXSnackBar.show("Success", "Please login to continue", false);
      Get.offAllNamed(logScreen);
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["errors"].toString(), true);
      debugPrint(response.body);
      return null;
    }
  }

  // Login..........................

  Future login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    http.Response? response;
    response = await _postRequest(
        context: context,
        url: Urls.login,
        body: {"email": email, "password": password});
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Get.offAllNamed(mainScreen);
      GetXSnackBar.show("Success", "Authentication Successful", false);
      debugPrint("hlo Success${data["data"]["user"]["name"]}");
      userToken = data["data"]["token"];
      userName = data["data"]["user"]["name"];
      userID = data["data"]["user"]["id"].toString();
      userEmail = data["data"]["user"]["email"].toString();
      log(userToken.toString());
      log(userName.toString());
      log(userID.toString());
      log(userEmail.toString());
      await prefs.setBool(keyIsLoggedIn, true);
      await prefs.setString(keyToken, data["data"]["token"].toString());
      await prefs.setString(keyUserId, data["data"]["user"]["id"].toString());
      await prefs.setString(keyEmail, data["data"]["user"]["email"].toString());
      await prefs.setString(keyName, data["data"]["user"]["name"].toString());
    } else {
      GetXSnackBar.show(
          data['status'].toString(), data['message'].toString(), true);
      debugPrint("error--------------$data");
      return null;
    }
  }

  // Forget Password Email Verification...........

  Future emailVerify({
    required BuildContext context,
    required String email,
  }) async {
    http.Response? response;
    response =
        await _postRequest(context: context, url: Urls.forgetPass, body: {
      "email": email,
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint("login--------$data");
      GetXSnackBar.show("Success", "Please Check Your Email", false);
      Get.toNamed(forPassScreen);
    } else {
      GetXSnackBar.show(data["status"].toString(), data["message"], true);
      debugPrint(response.body);
      return null;
    }
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  // Home Screen Apis<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  // Get Notifications..........

  Future<NotificationModel?> userNotifications({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await _getRequest(context: context, url: Urls.getNotification);
    var data = jsonDecode(response!.body);
    if (response.statusCode == 200) {
      debugPrint("notifications----------$data");
      return NotificationModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show("Error", "Connection Error", true);
      debugPrint("error--------------$data");
      return null;
    }
  }

  // Search Products...............

  Future searchProduct(
      {required BuildContext context, required searchTerm}) async {
    http.Response? response;
    response = await _postRequest(
        context: context,
        url: Urls.search,
        body: {"search_term": searchTerm.toString()});
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint("${data["msg"]}");
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      // GetXSnackBar.show("Error", "Connection Error", true);
      debugPrint("error--------------$data");
      return null;
    }
  }

  // Get Banner Image............

  Future<BannerModel?> banner({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await _getRequest(context: context, url: Urls.getBanner);
    var data = jsonDecode(response!.body);
    if (response.statusCode == 200) {
      debugPrint("banner----------$data");
      return BannerModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show("Error", "Connection Error", true);
      debugPrint("error--------------$data");
      return null;
    }
  }

  // Get Category................

  Future<CategoryModel?> getCategories({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await _getRequest(context: context, url: Urls.category);
    var data = jsonDecode(response!.body);
    if (response.statusCode == 200) {
      debugPrint("Categories----------$data");
      return CategoryModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show("Error", "Connection Error", true);
      debugPrint("error--------------$data");
      return null;
    }
  }

  // Get Product...................

  Future<ProductModel?> getProduct({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await _getRequest(context: context, url: Urls.products);
    var data = jsonDecode(response!.body);
    if (response.statusCode == 200) {
      debugPrint("Products----------$data");
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show("Error", "Connection Error", true);
      debugPrint("error--------------$data");
      return null;
    }
  }

  // Add to Cart....................

  Future addToCartApi(
      {required BuildContext context,
      required proId,
      required quantity,
      required varId}) async {
    http.Response? response;
    response = await _postRequest(context: context, url: Urls.addCart, body: {
      'product_id': proId,
      'quantity': quantity.toString(),
      'variant_id': varId
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      debugPrint("${data["message"]}");
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), false);
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), true);
    }
  }

  // Update WishList..............

  Future updateWishlistApi(
      {required BuildContext context, required productId}) async {
    http.Response? response;
    response = await _postRequest(
        context: context,
        url: Urls.updateWishlist,
        body: {"product_id": productId.toString()});
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint("${data["msg"]}");
    } else {
      GetXSnackBar.show(data["status"], data["msg"], true);
    }
  }

  // Get Product Details..........

  Future<ProductDetailModel?> productDetails({
    required BuildContext context,
    required proId,
  }) async {
    http.Response? response;
    response =
        await _getRequest(context: context, url: "${Urls.products}$proId");
    var data = jsonDecode(response!.body);

    if (response.statusCode == 200) {
      return ProductDetailModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), true);
      debugPrint(response.body);
      return null;
    }
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  // Drawer Screen Apis<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  // Add Address...........

  Future addAddress({
    required BuildContext context,
    required String houseNo,
    required String roadName,
    required String landmark,
    required String district,
    required String state,
    required String pin,
  }) async {
    http.Response? response;
    response =
        await _postRequest(context: context, url: Urls.addAddress, body: {
      "house_no": houseNo,
      "road_name": roadName,
      "landmark": landmark,
      "district": district,
      "state": state,
      "pin": pin,
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint("Add Address--------$data");
      GetXSnackBar.show("Success", "Address Added Successful", false);
      Get.offNamed(myAddScreen);
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), true);
      debugPrint(response.body);
      return null;
    }
  }

  // Get Address..........

  Future<AddressModel?> getAddress({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await _getRequest(context: context, url: Urls.address);
    var data = jsonDecode(response!.body);
    if (response.statusCode == 200) {
      debugPrint("Address----------$data");
      return AddressModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show("Error", "Connection Error", true);
      debugPrint("error--------------$data");
      return null;
    }
  }

  // Delete Address.........

  Future deleteAddressApi(
      {required BuildContext context, required addId}) async {
    http.Response? response;
    response = await _getRequest(
        context: context, url: Urls.addressDel + addId.toString());
    var data = jsonDecode(response!.body);
    if (response.statusCode == 200) {
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), false);
      debugPrint("Address----------$data");
      return (jsonDecode(response.body));
    } else {
      GetXSnackBar.show("Error", "Connection Error", true);
      debugPrint("error--------------$data");
      return null;
    }
  }

  // Update As Current Address......

  Future updateCurrentAddressApi(
      {required BuildContext context, required addId}) async {
    http.Response? response;
    response = await _postRequest(
        context: context, url: Urls.currentAdd + addId.toString(), body: {});
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint("${data["message"]}");
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), false);
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["msg"].toString(), true);
    }
  }

  // Get Favourites.........

  Future<FavoritesModel?> getFavorites({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await _getRequest(context: context, url: Urls.wishList);
    var data = jsonDecode(response!.body);

    if (response.statusCode == 200) {
      return FavoritesModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), true);
      debugPrint(response.body);
      return null;
    }
  }

  // Get Orders......

  Future<OrdersModel?> getOrders({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await _getRequest(
        context: context, url: Urls.orders + userID.toString());
    var data = jsonDecode(response!.body);
    if (response.statusCode == 200) {
      log(userID.toString());
      debugPrint("Orders----------$data");
      return OrdersModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), true);
      debugPrint("error--------------$data");
      return null;
    }
  }

  // Get Order Details......

  Future<OrderDetailsModel?> orderDetails({
    required BuildContext context,
    required billId,
  }) async {
    http.Response? response;
    response =
        await _getRequest(context: context, url: Urls.orderDetails + billId);
    var data = jsonDecode(response!.body);

    if (response.statusCode == 200) {
      return OrderDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), true);
      debugPrint(response.body);
      return null;
    }
  }

  // Reset Password...........

  Future resetPassword({
    required BuildContext context,
    required String password,
    required String newPass,
    required String confirmPass,
  }) async {
    http.Response? response;
    response = await _postRequest(context: context, url: Urls.resetPass, body: {
      "old_password": password,
      "new_password": newPass,
      "new_password_confirmation": confirmPass,
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint("Reset Password--------$data");
      GetXSnackBar.show("Success", "Password Reset Successful", false);
      Get.put(BottomNavController()).navigateToHome();
      Get.offNamed(mainScreen);
    } else {
      GetXSnackBar.show(data["status"].toString(), data["message"], true);
      debugPrint(response.body);
      return null;
    }
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  // Cart Screen Apis<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  // Get Cart Products.......

  Future<CartModel?> getCart({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await _getRequest(context: context, url: Urls.cart);
    var data = jsonDecode(response!.body);

    if (response.statusCode == 200) {
      return CartModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), true);
      debugPrint(response.body);
      return null;
    }
  }

  // Delete Cart Product.......

  Future delCartApi({required BuildContext context, required cartId}) async {
    http.Response? response;
    response = await _postRequest(
        context: context,
        url: Urls.cartDel,
        body: {'cart_id': cartId.toString()});
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint("${data["message"]}");
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), false);
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["msg"].toString(), true);
    }
  }

  // Update Cart Api......

  Future updateCart(
      {required BuildContext context,
      required cartId,
      required quantity}) async {
    http.Response? response;
    response =
        await _postRequest(context: context, url: Urls.updateCart, body: {
      'cart_id': cartId.toString(),
      'quantity': quantity.toString(),
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint("${data["message"]}");
    } else {
      // GetXSnackBar.show(
      //     data["status"].toString(), data["message"].toString(), false);
    }
  }

  // Checkout......

  Future checkoutApi(
      {required BuildContext context,
      required userId,
      required quantity,
      required proId}) async {
    http.Response? response;
    response = await _postRequest(context: context, url: Urls.checkout, body: {
      'user_id': userId,
      'cart_items*product_id': proId,
      'cart_items*quantity': quantity,
      'cart_items*variant_id': proId
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint("${data["message"]}");
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), false);
      orderId = data['order_id'].toString();
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), false);
    }
  }

  // Checkout Details......

  Future<OrderPlaceModel?> checkoutDetails({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await _getRequest(
        context: context, url: Urls.checkoutDetails + orderId!);
    var data = jsonDecode(response!.body);

    if (response.statusCode == 200) {
      return OrderPlaceModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), true);
      debugPrint(response.body);
      return null;
    }
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  // Profile Screen Apis<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  // Get Profile Data.......

  Future<ProfileModel?> getProfileDetailsApi(
      {required BuildContext context, userId}) async {
    http.Response? response;
    response = await _getRequest(
      context: context,
      url: Urls.userDetails,
    );
    var data = jsonDecode(response!.body);

    if (response.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show(
          data["status"].toString(), data["message"].toString(), true);
      debugPrint(response.body);
      return null;
    }
  }
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  // Category Screen Apis<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  // Get Sub category............

  Future<SubCatModel?> getSubCategories({
    required BuildContext context,
    required catId,
  }) async {
    http.Response? response;
    response = await _getRequest(
        context: context, url: Urls.subCat + catId.toString());
    var data = jsonDecode(response!.body);
    if (response.statusCode == 200) {
      debugPrint("Categories----------$data");
      return SubCatModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show("Error", "Connection Error", true);
      debugPrint("error--------------$data");
      return null;
    }
  }

  // get product details by Category..........

  Future<ProductModel?> getProductByCat(
      {required BuildContext context, required catId}) async {
    http.Response? response;
    response =
        await _getRequest(context: context, url: Urls.proByCatId + catId);
    var data = jsonDecode(response!.body);
    if (response.statusCode == 200) {
      debugPrint("Products----------$data");
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show("Error", "Connection Error", true);
      debugPrint("error--------------$data");
      return null;
    }
  }

  // Get Product Details By Sub Category..........

  Future<ProductModel?> getProductBySubCat(
      {required BuildContext context, required subCatId}) async {
    http.Response? response;
    response =
        await _getRequest(context: context, url: Urls.proBySubCatId + subCatId);
    var data = jsonDecode(response!.body);
    if (response.statusCode == 200) {
      debugPrint("Products----------$data");
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      GetXSnackBar.show("Error", "Connection Error", true);
      debugPrint("error--------------$data");
      return null;
    }
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  // Get Request Refactor:::::::::::::::::

  Future<http.Response?> _getRequest({
    required BuildContext context,
    required String url,
  }) async {
    http.Response? response;

    try {
      response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken",
          "x-api-key": apiKey
        },
      );

      debugPrint("$url----->${response.body}");
    } on SocketException {
      GetXSnackBar.show(
          "Something wrong", "Please check your connections", true);
    } catch (e) {
      rethrow;
    }
    return response;
  }

  // Post Request Refactor:::::::::::::::::

  Future<http.Response> _postRequest({
    required BuildContext context,
    required String url,
    required Map<String, String> body,
  }) async {
    late http.Response response;

    try {
      response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken",
          "x-api-key": apiKey
        },
      );
      debugPrint("$url----$body--->${response.body}");
    } on SocketException {
      GetXSnackBar.show(
          "Something wrong", "Please check your connections", true);
    } catch (e) {
      rethrow;
    }
    return response;
  }
}
