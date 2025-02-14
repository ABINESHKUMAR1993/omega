import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/authentication/email_verify_screen.dart';
import 'package:omiga_ipl/authentication/login_screen.dart';
import 'package:omiga_ipl/authentication/register_screen.dart';
import 'package:omiga_ipl/constants/bindings.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/views/screens/category_screen.dart';
import 'package:omiga_ipl/views/screens/checkout_screen.dart';
import 'package:omiga_ipl/views/screens/contact_us_screen.dart';
import 'package:omiga_ipl/views/screens/home_screen.dart';
import 'package:omiga_ipl/views/screens/main_screen.dart';
import 'package:omiga_ipl/views/screens/my_adress_screen.dart';
import 'package:omiga_ipl/views/screens/my_orders_screen.dart';
import 'package:omiga_ipl/views/screens/network_error_screen.dart';
import 'package:omiga_ipl/views/screens/notification_screen.dart';
import 'package:omiga_ipl/views/screens/reset_password_screen.dart';
import 'package:omiga_ipl/views/screens/search_screen.dart';
import 'package:omiga_ipl/views/screens/splash_screen.dart';
import 'package:omiga_ipl/views/screens/wish_list_screen.dart';
import 'package:omiga_ipl/views/widgets/success_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: home, page: () => HomeScreen()),
        GetPage(name: regScreen, page: () => RegisterScreen()),
        GetPage(name: logScreen, page: () => LoginScreen()),
        GetPage(name: mainScreen, page: () => MainScreen()),
        GetPage(name: emailVerScreen, page: () => EmailVerifyScreen()),
        GetPage(name: sucScreen, page: () => const SuccessScreen()),
        GetPage(name: checkScreen, page: () => CheckoutScreen()),
        GetPage(name: myAddScreen, page: () => const MyAddressScreen()),
        GetPage(name: wishlistScreen, page: () => WishListScreen()),
        GetPage(name: myOrdScreen, page: () => MyOrdersScreen()),
        GetPage(name: resetPassScreen, page: () => ResetPasswordScreen()),
        GetPage(name: cntUsScreen, page: () => const ContactUsScreen()),
        GetPage(name: searchScreen, page: () => const SearchScreen()),
        GetPage(name: catScreen, page: () => CategoryScreen()),
        GetPage(name: notScreen, page: () => NotificationScreen()),
        GetPage(name: netErrScreen, page: () => NetworkErrorScreen()),
        GetPage(name: splashScreen, page: () => SplashScreen()),
      ],
      transitionDuration: const Duration(microseconds: 1000),
      title: 'Omiga IPL',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              color: Colors.white, surfaceTintColor: Colors.transparent)),
      initialBinding: NetworkBinding(),
    );
  }
}
