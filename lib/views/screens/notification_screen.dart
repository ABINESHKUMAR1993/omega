import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/models/notification_model.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  NotificationModel? notificationData;

  // Function to format date
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));

    if (DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(now)) {
      return "Today";
    } else if (DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(yesterday)) {
      return "Yesterday";
    } else {
      return DateFormat('MMMM d').format(date); // e.g., "August 26"
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppbar(
            title: tNot,
            isBack: true,
          )),
      body: SafeArea(
          child: FutureBuilder(
        future: NetworkHelper().userNotifications(context: context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Connection Error"),
            );
          } else {
            notificationData = snapshot.data;
            return ListView.separated(
              reverse: true,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: notificationData!.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var details = notificationData!.data[index];
                return Container(
                  padding: const EdgeInsets.all(18),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.chat,
                        color: cPrimaryColor,
                      ),
                      SizedBox(
                        width: width * .03,
                      ),
                      SizedBox(
                        width: width * .7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatDate(details.date.toString()),
                              style: TextHelper.pop10W400G,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              details.title.toString(),
                              style: TextHelper.pop14W600B,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              details.content.toString(),
                              style: TextHelper.pop12W400G,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      )),
    );
  }
}
