import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/controllers/product_controller.dart';
import 'package:omiga_ipl/views/screens/product_detail_screen.dart';
import 'package:omiga_ipl/views/widgets/products_widget.dart';

class ProdWidget extends StatelessWidget {
  final ProductController _productController = Get.put(ProductController());
  ProdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _productController.getProduct(context: context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return Obx(() {
            return GridView.builder(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              itemCount: _productController.productData!.data.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                var product = _productController.productData!.data[index];
                var variation = product.variation![0];
                return ProductsWidget(
                  onTap: () {
                    Get.to(() => ProductDetailScreen(
                        productId: product.id.toString()))!
                        .then((result) {
                      if (result == 'refresh') {
                        _productController.getProduct(context: context);
                      }
                    });
                  },
                  isFavourite: product.isWishlist ?? false,
                  favButton: () async {
                    await _productController.toggleFavorite(
                        context: context, product.id!.toInt());
                  },
                  name: product.title.toString(),
                  image: product.image.toString(),
                  discount: "${variation.dis}",
                  amount: variation.dis == "0.00" ?'' : '₹${variation.mrp} ',
                  disAfter: "₹${variation.price}",
                  addBtn: () async {
                    await _productController.addToCart(
                      proId: variation.proId.toString(),
                      quantity: 1.toString(),
                      varId: variation.varId.toString(),
                    );
                  },
                );
              },
            );
          });
        }
      },
    );
  }
}
