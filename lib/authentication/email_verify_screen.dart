import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/authentication/auth_controller.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/views/widgets/app_button.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';
import 'package:omiga_ipl/views/widgets/textfield_widget.dart';

class EmailVerifyScreen extends StatelessWidget {
  EmailVerifyScreen({super.key});

  final EmailVerifyController controller = Get.put(EmailVerifyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppbar(
            title: tEmailVer,
            isBack: true,
          )),
      body: SafeArea(
        child: Form(
          key: controller.formKeyEmailVerify,
          onChanged: () {
            controller.areFilled.value =
                controller.formKeyEmailVerify.currentState?.validate() ?? false;
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tEmil,
                  style: TextHelper.pop14W400B,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  showSuffixIcon: false,
                  readOnly: false,
                  controller: controller.emailController,
                  obscureText: false,
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "Enter valid email",
                  hintText: "Enter Email",
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(
                  () => AppMainButton(
                    isLoading: controller.isLoading,
                    isDefault: true,
                    onTap: controller.areFilled.value
                        ? () {
                            controller.forgetPass(context);
                          }
                        : null,
                    text: tVerify,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
