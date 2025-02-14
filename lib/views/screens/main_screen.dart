import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_images.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/controllers/bottom_nav_controller.dart';
import 'package:omiga_ipl/views/screens/drawer_screen.dart';

class MainScreen extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * .064),
          child: Obx(
            () {
              return controller.selectedIndex.value == 0
                  ? AppBar(
                      leadingWidth: width * .18,
                      backgroundColor: Colors.white,
                      centerTitle: true,
                      // title: ClipRRect(
                      //   borderRadius: BorderRadius.circular(10),
                      //   child: Image.asset(
                      //     iLogo,
                      //     height: height * .05,
                      //   ),
                      // ),
                      actions: [
                        IconButton(
                            padding: const EdgeInsets.only(right: 14),
                            onPressed: () {
                              Get.toNamed(notScreen);
                            },
                            icon: const Icon(
                              Icons.notifications_none_outlined,
                              color: cBlue,
                            )),
                      ],
                    )
                  : AppBar(
                      backgroundColor: Colors.white,
                      automaticallyImplyLeading: false,
                    );
            },
          )),
      drawer: DrawerScreen(),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: _buildBottomNavigationBar(controller),
    );
  }

  Widget _buildBottomNavigationBar(BottomNavController controller) {
    return Obx(
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: controller.selectedIndex.value,
        selectedItemColor: cPrimaryColor,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        selectedLabelStyle: TextHelper.pop12W500B,
        unselectedLabelStyle: TextHelper.pop12W500B,
        onTap: controller.changeIndex,
        items: [
          _buildBottomNavigationBarItem(
            icon: iHome,
            label: tHme,
            index: 0,
            controller: controller,
          ),
          _buildBottomNavigationBarItem(
            icon: iCart,
            label: tCart,
            index: 1,
            controller: controller,
          ),
          _buildBottomNavigationBarItem(
            icon: iProfile,
            label: tProfile,
            index: 2,
            controller: controller,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String icon,
    required String label,
    required int index,
    required BottomNavController controller,
  }) {
    return BottomNavigationBarItem(
      icon: Obx(
        () => Column(
          children: [
            Transform.translate(
              offset: const Offset(0, -5),
              child: Container(
                height: 4,
                width: 90,
                decoration: BoxDecoration(
                  color: controller.selectedIndex.value == index
                      ? cPrimaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset(
              icon,
              color: controller.selectedIndex.value == index
                  ? cPrimaryColor
                  : Colors.black,
              height: 20,
              width: 20,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      label: label,
    );
  }
}
