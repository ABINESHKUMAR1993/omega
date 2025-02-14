import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/constants/user_data.dart';
import 'package:omiga_ipl/controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<CartController>(
              initState: (_) =>
                  controller.fetchCart(context), // Fetch favorites on load
              builder: (controller) {
                if (controller.cart == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.cart!.data.isEmpty) {
                  return const Center(
                    child: Text('Your Cart is empty'),
                  );
                }

                return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.cart!.data.length,
                    itemBuilder: (context, index) {
                      var cart = controller.cart!.data[index];
                      var qn = cart.quantity.obs;
                      return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 7),
                                    blurRadius: 15,
                                    spreadRadius: -2)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  cart.image.toString(),
                                  height: height * .08,
                                  width: width * .18,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * .05,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: width * .46,
                                          child: Text(
                                            cart.title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextHelper.pop14W600B,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * .04,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            controller.delCart(
                                                context, cart.id);
                                          },
                                          child: Text(
                                            trmve,
                                            style: TextHelper.pop10W400R,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * .3,
                                        child: Text(
                                          "₹ ${cart.price}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextHelper.pop14W600B,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * .03,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (qn.value > 1) {
                                            // Ensure quantity does not go below 1
                                            qn.value--; // Decrement the observable quantity
                                            await controller.updateCart(
                                                context,
                                                cart.id,
                                                qn.value); // Call the updateCart function
                                          }
                                        },
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: cPrimaryColor,
                                          child: Center(
                                            child: Text(
                                              '-',
                                              style: TextHelper.pop16W500W,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: width * .03),
                                      Obx(() {
                                        return Center(
                                          child: Text(
                                            qn.toString(),
                                            style: TextHelper.pop16W500B,
                                          ),
                                        );
                                      }),
                                      SizedBox(width: width * .03),
                                      InkWell(
                                        onTap: () async {
                                          qn.value++; // Increment the observable quantity
                                          await controller.updateCart(
                                              context,
                                              cart.id,
                                              qn.value); // Call the updateCart function
                                        },
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
                                ])
                          ]));
                    });
              })),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (controller) {
          if (controller.cart == null) {
            return const SizedBox
                .shrink(); // Return an empty widget or loading indicator
          }
          return ListTile(
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            title: Text(
              tTotPrce,
              style: TextHelper.pop16W500B,
            ),
            subtitle: Text(
              "₹ ${controller.cart?.totalPrice.toStringAsFixed(2) ?? '0.00'}", // Use a default value if null
              style: TextHelper.pop16W500P,
            ),
            trailing: InkWell(
              onTap: () {
                if (controller.cart?.data.isNotEmpty ?? false) {
                  String productIds = controller.cart!.data
                      .map((cart) => cart.id.toString())
                      .join(',');
                  String productQn = controller.cart!.data
                      .map((cart) => cart.quantity.toString())
                      .join(',');

                  NetworkHelper()
                      .checkoutApi(
                    context: context,
                    userId: userID,
                    quantity: productQn,
                    proId: productIds,
                  )
                      .then((response) {
                    Get.toNamed(checkScreen);
                  });
                }
              },
              child: Container(
                height: height * .06,
                width: width * .5,
                decoration: BoxDecoration(
                    color: cPrimaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    tChckOt,
                    style: TextHelper.pop16W500W,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
