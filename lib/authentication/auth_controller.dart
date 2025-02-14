import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';

//LOGIN CONTROLLER

class LoginController extends GetxController {
  //Key to check for validation throughout the textFields in real time
  final formKeyLogin = GlobalKey<FormState>();

  //Initializing Controller for required fields in Login Screen
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  //Boolean value to perform loading widget when loading period
  RxBool isLoading = false.obs;

  //Boolean To check if all the textFields are filled
  RxBool areFilled = false.obs;

  //Login function to perform login in APP
  void login(context) async {
    isLoading.value = true;
    try {
      await NetworkHelper().login(
          context: context,
          email: emailController.text.trim(),
          password: pwdController.text.trim());
    } finally {
      isLoading.value = false;
    }
  }

  //To dispose the controllers when navigating to the new screen
  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    pwdController.dispose();
  }
}

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

//REGISTER CONTROLLER

class RegisterController extends GetxController {
  //Key to check for validation throughout the textFields in real time
  final formKeySignUp = GlobalKey<FormState>();

  //Initializing Controller for required fields in Register Screen
  TextEditingController nameController = TextEditingController();
  TextEditingController phnNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController cfmPwdController = TextEditingController();

  //Boolean value to check the password validation
  RxBool isNote = false.obs;

  //Boolean value to check the checkbox value
  RxBool isAgree = false.obs;

  //Boolean To check if all the textFields are filled
  RxBool areFilled = false.obs;

  //Boolean value to perform loading widget when loading period
  RxBool isLoading = false.obs;

  //function to change the checkbox value
  void toggleAgree() {
    isAgree.value = !isAgree.value;
  }

  //Boolean function to check the password is strong
  bool isPasswordStrong(String value) {
    // Password must contain at least 8 characters including at least 1 special character
    final RegExp passwordRegex =
        RegExp(r'^(?=.*[!@#\$%^&*()_+{}|:"<>?]).{8,}$');
    return passwordRegex.hasMatch(value);
  }

  //Register function to perform Registration in APP
  void signUp(context) async {
    isLoading.value = true;
    try {
      await NetworkHelper().signUp(
        context: context,
        name: nameController.text.trim(),
        phnNumber: phnNoController.text.trim(),
        email: emailController.text.trim(),
        pwd: pwdController.text.trim(),
        confirmPwd: cfmPwdController.text.trim(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  //To dispose the controllers when navigating to the new screen
  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    phnNoController.dispose();
    emailController.dispose();
    pwdController.dispose();
    cfmPwdController.dispose();
  }
}

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

//Email Verify CONTROLLER for Password Change

class EmailVerifyController extends GetxController {
  //Key to check for validation throughout the textFields in real time
  final formKeyEmailVerify = GlobalKey<FormState>();

  //Initializing Controller for required fields in Register Screen
  TextEditingController emailController = TextEditingController();

  //Boolean value to perform loading widget when loading period
  RxBool isLoading = false.obs;

  //Boolean To check if all the textFields are filled
  RxBool areFilled = false.obs;

  //Reset Password function to perform  password change in APP
  void forgetPass(context) async {
    isLoading.value = true;
    try {
      await NetworkHelper().emailVerify(
        context: context,
        email: emailController.text.trim(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  //To dispose the controllers when navigating to the new screen
  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
  }
}
