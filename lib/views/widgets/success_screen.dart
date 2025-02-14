import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/controllers/bottom_nav_controller.dart';
import 'package:omiga_ipl/views/screens/main_screen.dart';
import 'package:omiga_ipl/views/widgets/app_button.dart';


class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Center(child: SvgPicture.asset('assets/images/success.svg',color: cPrimaryColor,)),
            const SizedBox(
              height: 20,
            ),
            Text(
             'Your Order Has Been Placed!',
              style: TextHelper.pop16W700B,
            ),
            const SizedBox(
              height: 20,
            ), Text(
                "You will receive an message shortly.",
                style: TextHelper.pop14W400G,
                textAlign: TextAlign.center,
              ),

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: AppMainButton(
          isDefault: true,
          text: "Done",
          onTap: () {
            Get.put(BottomNavController()).navigateToHome();
            Get.to(MainScreen());
          }, isLoading: false.obs,
        ),
      ),
    );
  }
}
