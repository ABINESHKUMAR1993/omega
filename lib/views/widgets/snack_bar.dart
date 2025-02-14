import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/main_colors.dart';

class GetXSnackBar {
  static void show(String title,msg,bool error){
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: msg,
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        margin: const EdgeInsets.all(15),
        borderRadius: 10,
        borderColor: cPrimaryColor,
        duration: const Duration(milliseconds: 2000),
        backgroundColor: error ? Colors.black.withOpacity(.5) : cPrimaryColor.withOpacity(.7),
        // icon: SvgPicture.asset("assets/svg/bottom_svg/Clip path group.svg",color: Colors.white,),
      ),
    );
  }
}