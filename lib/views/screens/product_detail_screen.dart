import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/controllers/product_detail_controller.dart';
import 'package:omiga_ipl/views/widgets/app_bar_btn.dart';
import 'package:omiga_ipl/views/widgets/app_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  ProductDetailScreen({super.key, required this.productId});

  final ProductDetailController controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    final ProductDetailController controller =
        Get.put(ProductDetailController());

    // Fetch product details when screen is built
    controller.fetchProductDetails(productId.toString());

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: cWhite.withOpacity(0.3),
          leading: Padding(
            padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
            child: SquareButton(
              onTap: () {
                Get.back(result: 'refresh');
              },
              icon: Icons.arrow_back_ios_outlined,
              isBack: true,
            ),
          ),
          actions: [
            Obx(() => IconButton(
                  padding: const EdgeInsets.only(right: 20),
                  onPressed: () async {
                    controller.updateWishlist();
                  },
                  icon: Icon(
                    controller.isWishlist.value
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: cRed,
                  ),
                )),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final productData = controller.productData.value!;
          return ListView(
            children: [
              Container(
                color: cWhite.withOpacity(0.3),
                height: height * .36,
                width: double.infinity,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      productData.data.image,
                      height: height * .26,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Text(
                    productData.data.title.toString(),
                    style: TextHelper.pop16W700B,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    productData.data.description.toString(),
                    style: TextHelper.pop14W400G,
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productData.data.variation.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 1.6,
                      crossAxisCount: 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        controller.selectVariant(index);
                      },
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: controller.selectedVariantIndex.value ==
                                        index
                                    ? cPrimaryColor
                                    : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              color:
                                  controller.selectedVariantIndex.value == index
                                      ? cPrimaryColor.withOpacity(0.2)
                                      : Colors.grey.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                productData.data.variation[index].unit
                                    .toString(),
                                style: TextHelper.pop12W500B,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        productData.data.package.toString(),
                        style: TextHelper.pop14W600B,
                      ),
                      SizedBox(width: width * .04),
                      Text(
                        '${productData.data.variation[controller.selectedVariantIndex.value].discount} % Discount',
                        style: TextHelper.pop10W400Gr,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    final variant = productData
                        .data.variation[controller.selectedVariantIndex.value];
                    return variant.discount == '0'
                        ? Text(
                            '₹ ${variant.mrp}',
                            textAlign: TextAlign.start,
                            style: TextHelper.pop16W500B,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Row(
                            children: [
                              Text(
                                '₹ ${variant.mrp}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: cGrey,
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: cGrey,
                                    decorationThickness: 2),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(width: width * .03),
                              Text(
                                '₹ ${variant.price}',
                                textAlign: TextAlign.start,
                                style: TextHelper.pop16W500B,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          );
                  }),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      InkWell(
                        onTap: controller.decrement,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: cPrimaryColor,
                          child: Center(
                              child: Text(
                            '-',
                            style: TextHelper.pop16W500W,
                          )),
                        ),
                      ),
                      SizedBox(width: width * .03),
                      Obx(() => Text(
                            '${controller.count}',
                            style: TextHelper.pop16W500B,
                          )),
                      SizedBox(width: width * .03),
                      InkWell(
                        onTap: controller.increment,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: cPrimaryColor,
                          child: Center(
                              child: Text(
                            '+',
                            style: TextHelper.pop16W500W,
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  AppMainButton(
                    isLoading: false.obs,
                    isDefault: true,
                    onTap: () async {
                      await controller.addToCart();
                    },
                    text: tAddToCrt,
                  ),
                ],
              ),
            ],
          );
        }
      }),
    );
  }
}
