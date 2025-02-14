import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/models/product_model.dart';
import 'package:omiga_ipl/views/screens/product_detail_screen.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ProductModel? productData;

  TextEditingController searchController = TextEditingController();

  void fetchProducts({String? search}) async {
    try {
      if (search != null && search.isNotEmpty) {
        productData = await NetworkHelper()
            .searchProduct(context: context, searchTerm: search);
      } else {
        productData = await NetworkHelper().getProduct(
          context: context,
        );
      }
      setState(() {});
    } catch (error) {
      debugPrint('Error fetching products: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppbar(
            title: '',
            isBack: true,
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                fetchProducts();
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    style: TextHelper.pop14W400B,
                    onChanged: (value) {
                      fetchProducts(search: value);
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                        color: cBlue,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 14),
                      hintText: 'Search a Product',
                      hintStyle: TextHelper.pop14W400B,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: cWhite.withOpacity(0.4))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: cWhite.withOpacity(0.4))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: cBlue)),
                      filled: true,
                      fillColor: cWhite.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Search Result",
                    style: TextHelper.pop14W400P,
                  ),
                  Expanded(
                    child: productData == null
                        ? const Center(child: Text("No results found"))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: productData?.data.length ?? 0,
                            itemBuilder: (context, index) {
                              var product = productData!.data[index];
                              return ListTile(
                                onTap: () {
                                  Get.to(() => ProductDetailScreen(
                                      productId: product.id.toString()));
                                },
                                title: Text(product.title.toString()),
                                subtitle: Text(product.catName.toString()),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
