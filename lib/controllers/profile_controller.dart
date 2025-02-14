import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/user_data.dart';
import 'package:omiga_ipl/controllers/bottom_nav_controller.dart';
import 'package:omiga_ipl/models/user_model.dart';


class ProfileController extends GetxController {
  RxBool isLoading = false.obs;

  ProfileModel? data;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phnCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  Rx<File?> imageFile = Rx<File?>(null);

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
        debugPrint("imgPath=>${imageFile.value}");
      } else {
        debugPrint("User canceled image picker");
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<dynamic> uploadProfile() async {
    Uri url = Uri.parse(Urls.profileUpdate);
    var request = http.MultipartRequest("POST", url);
    request.headers['Authorization'] = "Bearer $userToken";
    request.headers['x-api-key'] = apiKey;

    // Check if the image file exists and is not null
    if (imageFile.value != null && await imageFile.value!.exists()) {
      // Read the bytes of the image file
      Uint8List bytes = await imageFile.value!.readAsBytes();

      var myFile = http.MultipartFile(
        "profile_image",
        http.ByteStream.fromBytes(bytes),
        bytes.length,
        filename: imageFile.toString(),
      );
      request.files.add(myFile);

      // Add the name, email, and phone number to the request
      request.fields['name'] = nameCtrl.text; // Add name
      request.fields['email'] = emailCtrl.text; // Add email
      request.fields['phone_number'] = phnCtrl.text; // Add phone number

      // Sending the request
      final response = await request.send();
      if (response.statusCode == 200||response.statusCode == 201) {
        var data = await response.stream.bytesToString();
        log(response.statusCode.toString());
        Get.put(BottomNavController()).navigateToHome();
        Get.offNamed(mainScreen);
        return jsonDecode(data);
      } else {
        debugPrint("Upload failed with status: ${response.statusCode}");
        return null;
      }
    } else {
      debugPrint("Image file is null or does not exist");
      return null;
    }
  }

}
