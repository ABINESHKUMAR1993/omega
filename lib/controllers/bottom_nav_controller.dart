import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/views/screens/cart_screen.dart';
import 'package:omiga_ipl/views/screens/home_screen.dart';
import 'package:omiga_ipl/views/screens/profile_screen.dart';

class BottomNavController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var selectedIndex = 0.obs;
  final List<Widget> screens = [
    HomeScreen(),
     CartScreen(),
    ProfileScreen(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void navigateToCart() {
    selectedIndex.value = 1;
  }
  void navigateToHome() {
    selectedIndex.value = 0;
  }
}
