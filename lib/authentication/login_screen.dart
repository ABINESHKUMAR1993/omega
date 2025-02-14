import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/authentication/auth_controller.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/views/widgets/app_button.dart';
import 'package:omiga_ipl/views/widgets/textfield_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: loginController.formKeyLogin,
        onChanged: () {
          loginController.areFilled.value =
              loginController.formKeyLogin.currentState?.validate() ?? false;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  tLogin,
                  style: TextHelper.pop16W500B,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
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
                hintText: tEmil,
                obscureText: false,
                validator: (value) => EmailValidator.validate(value!)
                    ? null
                    : "Enter valid email",
                controller: loginController.emailController,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                tPassWrd,
                style: TextHelper.pop14W400B,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                showSuffixIcon: true,
                readOnly: false,
                hintText: tPassWrd,
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Your Password";
                  }
                  return null;
                },
                controller: loginController.pwdController,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed(emailVerScreen);
                      },
                      child: Text('Forget Password ?',
                          style: TextHelper.pop10W400R))),
              const SizedBox(
                height: 6,
              ),
              Obx(
                () => AppMainButton(
                  isLoading: loginController.isLoading,
                  isDefault: true,
                  onTap: loginController.areFilled.value
                      ? () {
                          loginController.login(context);
                        }
                      : null,
                  text: tSubmit,
                ),
              )
            ],
          ),
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don’t have account ? ", style: TextHelper.pop14W400G),
            InkWell(
                onTap: () {
                  Get.toNamed(regScreen);
                },
                child: Text(tReg, style: TextHelper.pop14W400P)),
          ],
        ),
      ),
    );
  }
}
