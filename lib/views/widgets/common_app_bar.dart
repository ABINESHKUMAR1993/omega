import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/views/widgets/app_bar_btn.dart';

class MainAppbar extends StatelessWidget {
  final String title;
  final bool isBack;
  final String? result;
  const MainAppbar({super.key, required this.title, required this.isBack, this.result});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextHelper.pop16W500B,
      ),
      leading: isBack == true
          ? Padding(
              padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
              child: SquareButton(
                onTap: () {
                  Get.back(result: result);
                },
                icon: Icons.arrow_back_ios_outlined,
                isBack: true,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
