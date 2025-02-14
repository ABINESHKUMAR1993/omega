import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/models/product_model.dart';
import 'package:omiga_ipl/models/sub_cat_model.dart';
import 'package:omiga_ipl/views/screens/product_detail_screen.dart';
import 'package:omiga_ipl/views/widgets/category_widget.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';
import 'package:omiga_ipl/views/widgets/products_widget.dart';

class SubCategoryScreen extends StatefulWidget {
  final String title;
  final String catId;
  const SubCategoryScreen(
      {super.key, required this.title, required this.catId});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  SubCatModel? subCategoryData;
  ProductModel? productData;
  String? selectedSubCatId; // Store selected subcategory ID
  bool isSubCatSelected = false; // To track if a subcategory is selected

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: MainAppbar(
          title: widget.title,
          isBack: true,
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          // Subcategory List
          SizedBox(
            height: height * .13,
            child: FutureBuilder(
              future: NetworkHelper().getSubCategories(
                  context: context, catId: widget.catId.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.data.isEmpty) {
                  return const SizedBox();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  subCategoryData = snapshot.data;
                  return ListView.separated(
                    padding: const EdgeInsets.only(left: 20),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(
                      width: width * .04,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: subCategoryData!.data.length,
                    itemBuilder: (context, index) {
                      var subCat = subCategoryData!.data[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSubCatId = subCat.id
                                .toString(); // Store selected subcategory ID
                            isSubCatSelected =
                                true; // Subcategory is now selected
                          });
                        },
                        child: CategoriesWidget(
                          image: subCat.image.toString(),
                          title: subCat.subcategoryName.toString(),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              tPrcdts,
              style: TextHelper.pop14W600B,
            ),
          ),
          // Show products based on whether a subcategory is selected
          FutureBuilder(
            future: isSubCatSelected
                ? NetworkHelper().getProductBySubCat(
                    context: context,
                    subCatId: selectedSubCatId ??
                        widget.catId.toString(), // Use selectedSubCatId
                  )
                : NetworkHelper().getProductByCat(
                    context: context,
                    catId: widget.catId.toString(), // Use category ID initially
                  ),
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
                productData = snapshot.data;
                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: productData!.data.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    var product = productData!.data[index];
                    var variation = product.variation![0];
                    return ProductsWidget(
                      onTap: () {
                        Get.to(() => ProductDetailScreen(
                            productId: product.id.toString()))!
                            .then((result) {
                          if (result == 'refresh') {
                            setState(() {});
                          }
                        });
                      },
                      isFavourite: product.isWishlist ?? false,
                      favButton: () async {
                        product.toggleFavorite(); // Toggle favorite status
                        await NetworkHelper().updateWishlistApi(
                          context: context,
                          productId: product.id,
                        );
                        setState(() {}); // Rebuild the UI to reflect the change
                      },
                      name: product.title.toString(),
                      image: product.image.toString(),
                      discount: variation.dis,
                      amount: "₹${variation.mrp}",
                      disAfter: "₹${variation.price}",
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
