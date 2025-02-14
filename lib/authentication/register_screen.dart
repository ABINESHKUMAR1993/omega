import 'dart:developer';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/authentication/auth_controller.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/views/widgets/app_button.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';
import 'package:omiga_ipl/views/widgets/textfield_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppbar(
            title: tReg,
            isBack: true,
          )),
      body: SafeArea(
          child: Form(
        key: controller.formKeySignUp,
        onChanged: () {
          controller.areFilled.value =
              controller.formKeySignUp.currentState?.validate() ?? false;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(tFullNme),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                showSuffixIcon: false,
                readOnly: false,
                hintText: "Enter $tFullNme",
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tFullNme;
                  }
                  return null;
                },
                controller: controller.nameController,
              ),
              const SizedBox(
                height: 18,
              ),
              buildText(tPhnNo),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                showSuffixIcon: false,
                readOnly: false,
                hintText: "Enter $tPhnNo",
                obscureText: false,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Phone Number';
                  } else if (value.length != 10) {
                    return 'Enter Valid Phone Number';
                  }
                  {
                    return null;
                  }
                },
                controller: controller.phnNoController,
              ),
              const SizedBox(
                height: 18,
              ),
              buildText(tEmil),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                showSuffixIcon: false,
                readOnly: false,
                hintText: "Enter $tEmil",
                obscureText: false,
                validator: (value) => EmailValidator.validate(value!)
                    ? null
                    : "Enter valid email",
                controller: controller.emailController,
              ),
              const SizedBox(
                height: 18,
              ),
              buildText(tPassWrd),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                showSuffixIcon: true,
                readOnly: false,
                hintText: "Enter Your $tPassWrd",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    controller.isNote.value = true;

                    return "Enter password";
                  } else if (!controller.isPasswordStrong(value)) {
                    controller.isNote.value = true;

                    return "Password must have 8 character and include a special character";
                  } else {
                    controller.isNote.value = false;

                    return null;
                  }
                },
                onChanged: (value) {
                  if (value.isEmpty) {
                    controller.isNote.value = false;
                  } else {
                    controller.isNote.value = true;
                  }
                },
                controller: controller.pwdController,
              ),
              const SizedBox(
                height: 18,
              ),
              buildText(tCnfrmPass),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                showSuffixIcon: true,
                readOnly: false,
                hintText: "Enter Your $tCnfrmPass",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter confirm password";
                  } else if (value != controller.pwdController.text) {
                    return "Password must be same";
                  }
                  return null;
                },
                controller: controller.cfmPwdController,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      focusColor: cPrimaryColor,
                      activeColor: cPrimaryColor,
                      side: const BorderSide(width: 1.5),
                      value: controller.isAgree.value,
                      onChanged: (value) {
                        controller.toggleAgree();
                      },
                    ),
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            'Registration implies acceptance of the ',
                            style: TextHelper.pop12W400G,
                          ),
                          InkWell(
                            onTap: () {
                              log('Terms of Service clicked');
                            },
                            child: Text('Terms of Service ',
                                style: TextHelper.pop12W400P),
                          ),
                          Text(
                            ' and ',
                            style: TextHelper.pop12W400G,
                          ),
                          InkWell(
                            onTap: () {
                              log('Privacy Policy clicked');
                            },
                            child: Text(' Privacy Policy',
                                style: TextHelper.pop12W400P),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => AppMainButton(
                  isDefault: true,
                  onTap: controller.areFilled.value && controller.isAgree.value
                      ? () {
                          controller.signUp(context);
                        }
                      : null,
                  isLoading: controller.isLoading,
                  text: tSubmit,
                ),
              )
            ],
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
