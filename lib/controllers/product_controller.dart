import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/models/product_model.dart';

class ProductController extends GetxController {
  final NetworkHelper _networkHelper = NetworkHelper();

  final Rx<ProductModel?> _productData = Rx(null);

  ProductModel? get productData => _productData.value;

  Future<void> getProduct({required BuildContext context}) async {
    final response = await _networkHelper.getProduct(context: context);
    _productData.value = response;
  }

  Future<void> toggleFavorite(int productId, {required BuildContext context}) async {
    await _networkHelper.updateWishlistApi(context: Get.context!, productId: productId);
    final response = await _networkHelper.getProduct(context: context);
    _productData.value = response;

  }

  Future<void> addToCart({
    required String proId,
    required String quantity,
    required String varId,
  }) async {
    await _networkHelper.addToCartApi(
      context: Get.context!,
      proId: proId,
      quantity: quantity,
      varId: varId,
    );
  }
}