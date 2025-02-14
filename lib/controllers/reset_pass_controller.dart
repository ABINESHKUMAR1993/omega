import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';

class ResetPassController extends GetxController {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController cnfrmNewPassController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool areFilled = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    super.onClose();
    oldPassController.dispose();
    newPassController.dispose();
    cnfrmNewPassController.dispose();
  }

  void resetPass(context) async {
    isLoading.value = true;
    try {
      await NetworkHelper().resetPassword(
        context: context,
        password: oldPassController.text.trim(),
        confirmPass: newPassController.text.trim(),
        newPass: cnfrmNewPassController.text.trim(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
