import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/controllers/connection_controller.dart';
import 'package:omiga_ipl/views/widgets/app_button.dart';

class NetworkErrorScreen extends StatelessWidget {
  NetworkErrorScreen({super.key});

  final NetworkController _networkController = Get.find<NetworkController>();

  navigateToSplash() async {
    if (_networkController.connectionStatus.value == 0) {
      Get.toNamed(netErrScreen);
      Get.snackbar("Retry Failed", "Still no network connection");
      log("_networkController.connectionStatus.value----${_networkController.connectionStatus.value}");
    } else {
      Get.offNamed(splashScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            30,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Network Error",
                  style: TextHelper.pop16W700Gr,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Please Check Your Connection",
                  style: TextHelper.pop12W400G,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: AppMainButton(
          isLoading: false.obs,
          isDefault: true,
          onTap: () {
            navigateToSplash();
          },
          text: 'Try Again',
        ),
      ),
    );
  }
}
