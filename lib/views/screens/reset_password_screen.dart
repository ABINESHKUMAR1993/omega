import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/controllers/reset_pass_controller.dart';
import 'package:omiga_ipl/views/widgets/app_button.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';
import 'package:omiga_ipl/views/widgets/textfield_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final ResetPassController controller =
  Get.put(ResetPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppbar(
            title: 'Reset Password',
            isBack: true,
          )),
      body: SafeArea(
          child: Form(
            key: controller.formKey,
            onChanged: () {
              controller.areFilled.value =
                  controller.formKey.currentState?.validate() ?? false;
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText('Old Password'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      showSuffixIcon: true,
                      readOnly: false,
                      hintText: "Enter Old Password",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Old Password";
                        }
                      },
                      controller: controller.oldPassController,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    buildText('New Password'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      showSuffixIcon: true,
                      readOnly: false,
                      hintText: "Enter New Password",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter New Password";
                        }
                      },
                      controller: controller.newPassController,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    buildText('Confirm Password'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      showSuffixIcon: true,
                      readOnly: false,
                      hintText: "Enter Confirm Password",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter New Password";
                        }
                      },
                      controller: controller.cnfrmNewPassController,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Obx(
                          () => AppMainButton(
                        isLoading: controller.isLoading,
                        isDefault: true,
                        onTap: controller.areFilled.value
                            ? () {
                          controller.resetPass(context);
                        }
                            : null,
                        text: 'Set Password',
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Text buildText(String title) {
    return Text(
      title,
      style: TextHelper.pop12W500B,
    );
  }
}
