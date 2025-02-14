import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/constants.dart';
import 'package:omiga_ipl/controllers/fav_controller.dart';
import 'package:omiga_ipl/views/screens/product_detail_screen.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';
import 'package:omiga_ipl/views/widgets/products_widget.dart';

class WishListScreen extends StatelessWidget {
  final FavoriteController _favoritesController = Get.put(FavoriteController());

  WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MainAppbar(
          title: 'Wishlist',
          result: 'refresh',
          isBack: true,
        ),
      ),
      body: SafeArea(
        child: GetBuilder<FavoriteController>(
          initState: (_) => _favoritesController
              .fetchFavorites(context), // Fetch favorites on load
          builder: (controller) {
            if (controller.favorites == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (controller.favorites!.data.isEmpty) {
              return const Center(
                child: Text('Your wishlist is empty'),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.favorites!.data.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                var product = controller.favorites!.data[index];
                var variation = product.product.variants[0];
                return ProductsWidget(
                  addBtn: () async {
                    await NetworkHelper().addToCartApi(
                        context: context,
                        proId: product.product.id.toString(),
                        quantity: 1.toString(),
                        varId: variation.id.toString());
                  },
                  onTap: () {
                    Get.to(() => ProductDetailScreen(
                            productId: product.product.id.toString()))!
                        .then((result) {
                      if (result == 'refresh') {
                        _favoritesController.fetchFavorites(context);
                      }
                    });
                  },
                  isFavourite: true,
                  favButton: () async {
                    // Toggle favorite and remove from list
                    await controller.toggleFavorite(
                        context, product.product.id);
                  },
                  name: product.product.title.toString(),
                  image: imgUrl + product.product.image.toString(),
                  discount: variation.discount,
                  amount:
                      variation.discount == "0.00" ? '' : '₹${variation.mrp} ',
                  disAfter: "₹${variation.price}",
                );
              },
            );
          },
        ),
      ),
    );
  }
}
