import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/models/orders_model.dart';
import 'package:omiga_ipl/views/screens/order_detail_screen.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({super.key});

  OrdersModel? orderData;

  String formatDate(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('dd MMM yyyy').format(parsedDate);
  }

  TextStyle getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return TextHelper.pop12W400Gr;
      case 'shipped':
        return TextHelper.pop12W400P;
      case 'pending':
        return TextHelper.pop12W400R;
      case 'delivered':
        return TextHelper.pop12W400Gr;
      default:
        return TextHelper.pop12W400G;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppbar(
            title: tMyOrdrs,
            isBack: true,
          )),
      body: FutureBuilder<OrdersModel?>(
        future: NetworkHelper().getOrders(context: context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.data == null) {
            return const Center(
              child: Text('No orders available.'),
            );
          } else {
            orderData = snapshot.data;
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              padding: const EdgeInsets.all(20),
              itemCount: orderData!.data.length,
              itemBuilder: (context, index) {
                var order = orderData!.data[index];
                return InkWell(
                  onTap: () {
                    Get.to(OrderDetailScreen(billId: order.billId.toString()));
                  },
                  child: Container(
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '$tOrdrNum : ',
                              style: TextHelper.pop14W400B,
                            ),
                            const Spacer(),
                            SizedBox(
                              width: width*.4,
                              child: Text(
                                 order.billId.toString(),
                                style: TextHelper.pop16W500B,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              formatDate(order.orderDate.toString()),
                              style: TextHelper.pop14W400B,
                            ),
                            const Spacer(),
                            Text(
                              order.status.toString(),
                              style: getStatusColor(order.status.toString()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
