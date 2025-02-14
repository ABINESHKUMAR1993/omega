import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';

class AddressController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool areFilled = false.obs;
  RxBool isLoading = false.obs;

  TextEditingController houseNoController = TextEditingController();
  TextEditingController roadNameController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    houseNoController.dispose();
    roadNameController.dispose();
    landmarkController.dispose();
    districtController.dispose();
    stateController.dispose();
    pinController.dispose();
  }

  void addAddress(context) async {
    isLoading.value = true;
    try {
      await NetworkHelper().addAddress(
        context: context,
        district: districtController.text.trim(),
        state: stateController.text.trim(),
        landmark: landmarkController.text.trim(),
        roadName: roadNameController.text.trim(),
        houseNo: houseNoController.text.trim(),
        pin: pinController.text.trim(),
      );
    } finally {
      isLoading.value = false;
      districtController.clear();
      stateController.clear();
      landmarkController.clear();
      roadNameController.clear();
      houseNoController.clear();
      pinController.clear();

    }
  }
}
