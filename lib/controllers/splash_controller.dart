import 'package:get/get.dart';
import 'package:omiga_ipl/authentication/login_screen.dart';
import 'package:omiga_ipl/constants/user_data.dart';
import 'package:omiga_ipl/controllers/connection_controller.dart';
import 'package:omiga_ipl/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final NetworkController _networkController = Get.put(NetworkController());

  @override
  void onInit() {
    fetchData();
    checkConnection();
    super.onInit();
  }

  splashNavigation() async {
    Get.off(
      () => userID == null ? LoginScreen() : MainScreen(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 2000),
    );
  }

  checkConnection() async {
    _networkController.initialized;

    if (_networkController.connectionStatus.value == 0) {
      await Future.delayed(const Duration(seconds: 2));
      splashNavigation();
    } else {
      splashNavigation();
    }
  }

  fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString(keyToken);
    userID = prefs.getString(keyUserId);
    userName = prefs.getString(keyName);
    userEmail = prefs.getString(keyEmail);
  }
}
