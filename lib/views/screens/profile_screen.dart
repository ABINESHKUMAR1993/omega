import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_images.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/controllers/profile_controller.dart';
import 'package:omiga_ipl/views/widgets/app_button.dart';
import 'package:omiga_ipl/views/widgets/textfield_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: NetworkHelper().getProfileDetailsApi(context: context),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            controller.data = snapshot.data;
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Center(
                  child: Obx(() {
                    return Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: cPrimaryColor.withOpacity(0.1),
                          radius: 60,
                          foregroundColor: cPrimaryColor.withOpacity(0.3),
                          backgroundImage: controller.imageFile.value != null
                              ? FileImage(controller.imageFile.value!)
                              : (controller.data!.data!.profileImage != null &&
                              controller.data!.data!.profileImage!.isNotEmpty)
                                  ? NetworkImage(controller.data!.data!.profileImage!)
                                  : null,
                          child: controller.imageFile.value == null &&
                                  (controller.data!.data!.profileImage == null ||
                                      controller.data!.data!.profileImage!.isEmpty)
                              ? const Center(
                                  child: Icon(
                                    Icons.person,
                                    size: 100,
                                  ),
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: cPrimaryColor,
                            radius: 18,
                            child: Center(
                              child: IconButton(
                                onPressed: controller.pickImage,
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$tUserId : ", style: TextHelper.pop16W500B),
                        TextSpan(
                          text: controller.data!.data?.userId.toString() ?? "0000000",
                          style: TextHelper.pop16W500Gr,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                buildText(tFullNme),
                const SizedBox(height: 10),
                CustomTextField(
                  readOnly: false,
                  hintText: "Enter Your $tFullNme",
                  obscureText: false,
                  controller: controller.nameCtrl
                    ..text = controller.data?.data?.name ?? "Full Name",
                  showSuffixIcon: false,
                ),
                const SizedBox(height: 18),
                buildText(tEmil),
                const SizedBox(height: 10),
                CustomTextField(
                  readOnly: false,
                  hintText: "Enter Your $tEmil",
                  obscureText: false,
                  controller: controller.emailCtrl
                    ..text = controller.data?.data?.email ?? "Email",
                  showSuffixIcon: false,
                ),
                const SizedBox(height: 18),
                buildText(tPhnNum),
                const SizedBox(height: 10),
                CustomTextField(
                  prefix: Container(
                    padding: const EdgeInsets.only(left: 6),
                    width: width * .22,
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        SvgPicture.asset(iFlag),
                        const SizedBox(width: 8),
                        const Text(
                          "+91",
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          color: cGrey,
                          height: 30,
                          width: 1.5,
                        ),
                      ],
                    ),
                  ),
                  readOnly: false,
                  hintText: "0000000000",
                  obscureText: false,
                  controller: controller.phnCtrl
                    ..text = controller.data?.data?.phoneNumber ?? "Phone Number",
                  showSuffixIcon: false,
                ),
                const SizedBox(height: 32),
                AppMainButton(
                  isLoading: controller.isLoading,
                  onTap: controller.uploadProfile,
                  text: 'Set Profile',
                  isDefault: true,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Text buildText(String title) {
    return Text(
      title,
      style: TextHelper.pop12W500B,
    );
  }
}
