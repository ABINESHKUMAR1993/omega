import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_images.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/views/widgets/app_button.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppbar(
            title: tForPass,
            isBack: true,
          )),
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 30,
          ),
          Center(
              child: SvgPicture.asset(
            iSuccess,
            color: cPrimaryColor,
          )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "A confirmation email has been",
                    style: TextHelper.pop14W400B,
                  ),
                  TextSpan(
                    text: " successfully sent to the provided email address.",
                    style: TextHelper.pop14W400P,
                  ),
                  TextSpan(
                    text: " Please check your inbox for further instructions.",
                    style: TextHelper.pop14W400B,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: AppMainButton(
          isDefault: true,
          onTap: () {
            Get.toNamed(logScreen);
          },
          text: tLogin,
          isLoading: false.obs,
        ),
      ),
    );
  }
}
