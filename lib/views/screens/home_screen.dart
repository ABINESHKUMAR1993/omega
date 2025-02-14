import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/models/banner_model.dart';
import 'package:omiga_ipl/models/category_model.dart';
import 'package:omiga_ipl/views/screens/sub_category_screen.dart';
import 'package:omiga_ipl/views/widgets/category_widget.dart';
import 'package:omiga_ipl/views/widgets/home_products.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  CarouselController carouselController = CarouselController();
  BannerModel? banner;
  CategoryModel? categoryData;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.none,
              onTap: () {
                Get.toNamed(searchScreen);
              },
              style: TextHelper.pop14W400B,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.search,
                  color: cBlue,
                ),
                isDense: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                constraints:
                    const BoxConstraints(minHeight: 50, maxHeight: 100),
                hintText: 'Search a Product',
                errorStyle: const TextStyle(
                    color: cRed,
                    fontFamily: "Poppins",
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
                hintStyle: TextHelper.pop14W400B,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: cWhite.withOpacity(0.4))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: cWhite.withOpacity(0.4))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: cWhite.withOpacity(0.4))),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: cWhite.withOpacity(0.4))),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: cWhite.withOpacity(0.4))),
                filled: true,
                fillColor: cWhite.withOpacity(0.4),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FutureBuilder(
            future: NetworkHelper().banner(context: context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.data!.data.isEmpty) {
                return const SizedBox();
              } else {
                banner = snapshot.data;
                return CarouselSlider(
                  // carouselController: carouselController,
                  options: CarouselOptions(
                    autoPlay: false,
                    height: height * .23,
                    aspectRatio: 16 / 14,
                    viewportFraction: 0.90,
                    enableInfiniteScroll: true,
                    scrollDirection: Axis.horizontal,
                    initialPage: 0,
                    disableCenter: true,
                    padEnds: true,
                  ),
                  items: banner!.data.map((e) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              e.image.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }
            },
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  tCatg,
                  style: TextHelper.pop14W600B,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Get.toNamed(catScreen);
                  },
                  child: Text(
                    tViewAll,
                    style: TextHelper.pop14W400P,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: height * .13,
            child: FutureBuilder(
              future: NetworkHelper().getCategories(context: context),
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
                  categoryData = snapshot.data;
                  return ListView.separated(
                    padding: const EdgeInsets.only(left: 20),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(
                      width: width * .04,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryData!.data.length,
                    itemBuilder: (context, index) {
                      return CategoriesWidget(
                        onTap: () {
                          Get.to(
                            () => SubCategoryScreen(
                                catId: categoryData!.data[index].id.toString(),
                                title: categoryData!.data[index].catName ?? ""),
                          );
                        },
                        image: categoryData!.data[index].image.toString(),
                        title: categoryData!.data[index].catName ?? "",
                      );
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              tAllProd,
              style: TextHelper.pop14W600B,
            ),
          ),
          ProdWidget()
        ],
      ),
    );
  }
}
