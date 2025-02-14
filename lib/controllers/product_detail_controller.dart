import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/models/product_detail_model.dart';

class ProductDetailController extends GetxController {
  var isLoading = true.obs;
  var productData = Rxn<ProductDetailModel>();
  var selectedVariantIndex = 0.obs;
  var count = 1.obs;
  var isWishlist = false.obs;

  void fetchProductDetails(String productId) async {
    try {
      isLoading(true);
      var response = await NetworkHelper().productDetails(
        context: Get.context!,
        proId: productId,
      );
      if (response != null) {
        productData.value = response;
        isWishlist.value = response.data.isWishlist ?? false;
      }
    } finally {
      isLoading(false);
    }
  }

  void updateWishlist() async {
    if (productData.value == null) return;

    await NetworkHelper().updateWishlistApi(
      context: Get.context!,
      productId: productData.value!.data.id.toString(),
    );
    // Toggle the wishlist status
    isWishlist.value = !isWishlist.value;
  }

  void selectVariant(int index) {
    selectedVariantIndex.value = index;
  }

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }

  Future<void> addToCart() async {
    if (productData.value == null) return;

    await NetworkHelper().addToCartApi(
      context: Get.context!,
      varId: productData.value!.data.variation[selectedVariantIndex.value].varId
          .toString(),
      proId: productData.value!.data.id.toString(),
      quantity: count.value.toString(),
    );
  }
}
