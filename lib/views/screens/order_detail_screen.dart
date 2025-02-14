import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/models/order_detail_model.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';
import 'package:omiga_ipl/views/widgets/custom_row.dart';

class OrderDetailScreen extends StatelessWidget {
  final String billId;
  OrderDetailScreen({super.key, required this.billId});

  OrderDetailsModel? orderData;

  String formatDate(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('dd MMM yyyy').format(parsedDate);
  }

  TextStyle getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return TextHelper.pop16W700Gr;
      case 'shipped':
        return TextHelper.pop16W700P;
      case 'pending':
        return TextHelper.pop16W700R;
      case 'delivered':
        return TextHelper.pop16W700B;
      default:
        return TextHelper.pop16W700G;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: MainAppbar(
          title: "$tOrdrNum : $billId",
          isBack: true,
        ),
      ),
      body: FutureBuilder(
        future: NetworkHelper().orderDetails(context: context, billId: billId),
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
                Center(
                  child: Text(
                    formatDate(orderData!.data.orderItems.first.orderDate.toString()),
                   textAlign: TextAlign.center,
                    style: TextHelper.pop16W500B,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                    child: Text(
                  orderData!.data.orderItems.first.status.toString(),
                  style: getStatusColor(
                      orderData!.data.orderItems.first.status.toString()),
                )), // Displaying order status
                const SizedBox(height: 20),
                Text(tOrdrSmry, style: TextHelper.pop16W500B),

                // Display the list of products dynamically
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final product =
                        orderData!.data.orderItems.first.products[index];
                    return CustomRow(
                      prefixText: product.productName.toString(), // Product name
                      suffixText: '${product.quantity}', // Product quantity
                      isBox: true,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: orderData!.data.orderItems.first.products.length,
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 7),
                        blurRadius: 15,
                        spreadRadius: -2,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      CustomRow(
                        prefixText: tSubTot,
                        suffixText:

                        '₹ ${double.parse(orderData!.data.subtotal.toString()).toStringAsFixed(2)}', // Total amount with 3 decimal places
                        isBox: false,
                        prefixStyle: TextHelper.pop14W400G,
                        suffixStyle: TextHelper.pop14W400B,
                      ),
                      const SizedBox(height: 6),
                      CustomRow(
                        prefixText: tDlvryFee,
                        suffixText:
                            '₹ ${orderData!.data.deliveryFee}.00', // Delivery fee
                        isBox: false,
                        prefixStyle: TextHelper.pop14W400G,
                        suffixStyle: TextHelper.pop14W400B,
                      ),
                      const SizedBox(height: 6),
                      const Divider(color: cGrey),
                      const SizedBox(height: 6),
                      CustomRow(
                        prefixText: tTot,
                        suffixText:
                            '₹ ${double.parse(orderData!.data.totalAmount.toString()).toStringAsFixed(2)}', // Total amount
                        isBox: false,
                        prefixStyle: TextHelper.pop14W400G,
                        suffixStyle: TextHelper.pop14W400B,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
