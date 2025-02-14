import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/models/category_model.dart';
import 'package:omiga_ipl/views/screens/sub_category_screen.dart';
import 'package:omiga_ipl/views/widgets/category_widget.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  CategoryModel? categoryData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppbar(
            title: tCatg,
            isBack: true,
          ),
        ),
        body: FutureBuilder(
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
                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: categoryData!.data.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2 / 3,
                    crossAxisCount: 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return CategoriesWidget(
                      onTap: () {
                        Get.to(
                          SubCategoryScreen(
                            title: categoryData!.data[index].catName ?? "",
                            catId: categoryData!.data[index].id.toString(),
                          ),
                        );
                      },
                      image: categoryData!.data[index].image.toString(),
                      title: categoryData!.data[index].catName ?? "",
                    );
                  },
                );
              }
            }));
  }
}
