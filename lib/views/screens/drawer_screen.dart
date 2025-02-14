import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/controllers/product_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatelessWidget {
   DrawerScreen({
    super.key,
  });
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero)),
      backgroundColor: Colors.white,
      shadowColor: cBlue,
      elevation: 20,
      width: width * .79,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: cBlue,
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            drawerFields(
                title: tMyAddress,
                onTap: () {
                  Get.back();
                  Get.toNamed(myAddScreen);
                }),
            drawerFields(
                title: tWishList,
                onTap: () {
                  Get.toNamed(wishlistScreen)!.then((result) {
                    if (result == 'refresh') {
                      controller.getProduct(context: context);
                    }
                  });
                }),
            drawerFields(
                title: tMyOrder,
                onTap: () {
                  Get.back();
                  Get.toNamed(myOrdScreen);
                }),
            drawerFields(
                title: tResetPass,
                onTap: () {
                  Get.back();
                  Get.toNamed(resetPassScreen);
                }),
            drawerFields(
                title: tCntctUs,
                onTap: () {
                  Get.back();
                  Get.toNamed(cntUsScreen);
                }),
            drawerFields(title: tPrvcyPlcy, onTap: () {}),
            drawerFields(title: tTmsAndCond, onTap: () {}),
            const Spacer(),
            ListTile(
              title: Text(
                tLgOut,
                style: TextHelper.pop16W500R,
              ),
              onTap: () {
                _showConfirmDialog(context);
              },
            )
          ],
        ),
      ),
    );
  }

  ListTile drawerFields({required String title, onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: TextHelper.pop16W500B,
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
            height: height * .08,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                tLogoutCnfrm,
                style: TextHelper.pop16W700B,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actions: [
            _confirmBtn(
                btn1: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Get.offAllNamed(logScreen);
                },
                btn2: () {
                  Get.back();
                },
                title1: tLogMeOut,
                title2: tStayIn)
          ],
        );
      },
    );
  }

  Widget _confirmBtn(
      {required String title1,
      required String title2,
      required btn1,
      required btn2}) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: btn1,
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: cGrey),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    title1,
                    style: TextHelper.pop14W600B,
                  ),
                )),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: InkWell(
            onTap: btn2,
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: cPrimaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    title2,
                    style: TextHelper.pop14W600W,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
