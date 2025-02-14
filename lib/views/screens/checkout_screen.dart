import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/controllers/checkout_controller.dart';
import 'package:omiga_ipl/models/order_place_model.dart';
import 'package:omiga_ipl/views/widgets/app_button.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';
import 'package:omiga_ipl/views/widgets/custom_row.dart';
import 'package:omiga_ipl/views/widgets/textfield_widget.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({
    super.key,
  });
  final CheckoutController controller = Get.put(CheckoutController());
  OrderPlaceModel? orderData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppbar(
            title: tChckOt,
            isBack: true,
          )),
      body: FutureBuilder(
        future: NetworkHelper().checkoutDetails(context: context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            orderData = snapshot.data;

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  tOrdrSmry,
                  style: TextHelper.pop16W500B,
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final product = orderData!.data.cartItems[index];
                    return CustomRow(
                        prefixText: product.productDetailsName,
                        suffixText: product.quantity.toString(),
                        isBox: true);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: orderData!.data.cartItems.length,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
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
                  child: Column(
                    children: [
                      CustomRow(
                        prefixText: tSubTot,
                        suffixText: orderData!.data.subtotal.toString(),
                        isBox: false,
                        prefixStyle: TextHelper.pop14W400G,
                        suffixStyle: TextHelper.pop14W400B,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      CustomRow(
                        prefixText: tDlvryFee,
                        suffixText: orderData!.data.deliveryFee.toString(),
                        isBox: false,
                        prefixStyle: TextHelper.pop14W400G,
                        suffixStyle: TextHelper.pop14W400B,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Divider(
                        color: cGrey,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      CustomRow(
                        prefixText: tTot,
                        suffixText: orderData!.data.totalAmount.toString(),
                        isBox: false,
                        prefixStyle: TextHelper.pop14W400G,
                        suffixStyle: TextHelper.pop14W400B,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      _showConfirmDialog(context);
                    },
                    child: Text(
                      tPacInstr,
                      style: TextHelper.pop16W600Y,
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  tOrdrSmry,
                  style: TextHelper.pop16W500B,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
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
                  child: Text(
                    orderData!.data.deliveryAddress.toString(),
                    style: TextHelper.pop16W500B,
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: AppMainButton(
          isLoading: false.obs,
          isDefault: true,
          onTap: () {
            controller.placeOrder(
                orderData!, controller.instructionController.text);
          },
          text: tPlcOrdr,
        ),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: height * .14,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tPacInstr,
                  style: TextHelper.pop16W500B,
                ),
                SizedBox(
                  height: height * .03,
                ),
                CustomTextField(
                  showSuffixIcon: false,
                  readOnly: false,
                  hintText: tWrteHre,
                  obscureText: false,
                  controller: controller.instructionController,
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: AppMainButton(
                isLoading: false.obs,
                isDefault: true,
                onTap: () {
                  Get.back();
                },
                text: 'Submit',
              ),
            ),
          ],
        );
      },
    );
  }
}
