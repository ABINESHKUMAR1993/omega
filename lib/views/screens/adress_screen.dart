import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/controllers/address_controller.dart';
import 'package:omiga_ipl/views/widgets/app_button.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';
import 'package:omiga_ipl/views/widgets/textfield_widget.dart';

class AddressScreen extends StatelessWidget {
  final bool isShow;
  final String? houNo;
  final String? roadName;
  final String? landmark;
  final String? district;
  final String? state;
  final String? pin;

  AddressScreen(
      {super.key,
      required this.isShow,
      this.houNo,
      this.roadName,
      this.landmark,
      this.district,
      this.state,
      this.pin});

  final AddressController controller = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return isShow
        ? Scaffold(
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: MainAppbar(
                  title: tAddAdrs,
                  isBack: true,
                )),
            body: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              children: [
                buildText(tHouseNoBuildNme),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    showSuffixIcon: false,
                    readOnly: false,
                    hintText: "Enter $tHouseNoBuildNme",
                    obscureText: false,
                    controller: controller.houseNoController
                      ..text = houNo.toString()),
                const SizedBox(
                  height: 18,
                ),
                buildText(tRdNme),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  showSuffixIcon: false,
                  readOnly: false,
                  hintText: "Enter $tRdNme",
                  obscureText: false,
                  controller: controller.roadNameController
                    ..text = roadName.toString(),
                ),
                const SizedBox(
                  height: 18,
                ),
                buildText(tLndMrkLocLink),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  showSuffixIcon: false,
                  readOnly: false,
                  hintText: "Enter $tLndMrkLocLink",
                  obscureText: false,
                  controller: controller.landmarkController
                    ..text = landmark.toString(),
                ),
                const SizedBox(
                  height: 18,
                ),
                buildText(tDistrict),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  showSuffixIcon: false,
                  readOnly: false,
                  hintText: "Enter Your $tDistrict",
                  obscureText: false,
                  controller: controller.districtController
                    ..text = district.toString(),
                ),
                const SizedBox(
                  height: 18,
                ),
                buildText(tState),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  showSuffixIcon: false,
                  readOnly: false,
                  hintText: "Enter Your $tState",
                  obscureText: false,
                  controller: controller.stateController
                    ..text = state.toString(),
                ),
                const SizedBox(
                  height: 18,
                ),
                buildText(tPinCde),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  showSuffixIcon: false,
                  readOnly: false,
                  hintText: "Enter $tPinCde",
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  controller: controller.pinController..text = pin.toString(),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: AppMainButton(
                isLoading: controller.isLoading,
                isDefault: true,
                onTap: () {},
                text: tSubmit,
              ),
            ))
        : Scaffold(
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: MainAppbar(
                  title: tAddAdrs,
                  isBack: true,
                )),
            body: Form(
              key: controller.formKey,
              onChanged: () {
                controller.areFilled.value =
                    controller.formKey.currentState?.validate() ?? false;
              },
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  buildText(tHouseNoBuildNme),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      showSuffixIcon: false,
                      readOnly: false,
                      hintText: "Enter $tHouseNoBuildNme",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tHouseNoBuildNme;
                        }
                        return null;
                      },
                      controller: controller.houseNoController..text = ''),
                  const SizedBox(
                    height: 18,
                  ),
                  buildText(tRdNme),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      showSuffixIcon: false,
                      readOnly: false,
                      hintText: "Enter $tRdNme",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter $tRdNme";
                        }
                        return null;
                      },
                      controller: controller.roadNameController..text = ''),
                  const SizedBox(
                    height: 18,
                  ),
                  buildText(tLndMrkLocLink),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      showSuffixIcon: false,
                      readOnly: false,
                      hintText: "Enter $tLndMrkLocLink",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter $tLndMrkLocLink";
                        }
                        return null;
                      },
                      controller: controller.landmarkController..text = ''),
                  const SizedBox(
                    height: 18,
                  ),
                  buildText(tDistrict),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      showSuffixIcon: false,
                      readOnly: false,
                      hintText: "Enter Your $tDistrict",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Your $tDistrict";
                        }
                        return null;
                      },
                      controller: controller.districtController..text = ''),
                  const SizedBox(
                    height: 18,
                  ),
                  buildText(tState),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      showSuffixIcon: false,
                      readOnly: false,
                      hintText: "Enter Your $tState",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Your $tState";
                        }
                        return null;
                      },
                      controller: controller.stateController..text = ''),
                  const SizedBox(
                    height: 18,
                  ),
                  buildText(tPinCde),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      showSuffixIcon: false,
                      readOnly: false,
                      hintText: "Enter $tPinCde",
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter $tPinCde";
                        }
                        return null;
                      },
                      controller: controller.pinController..text = ''),
                  const SizedBox(
                    height: 32,
                  ),
                  Obx(
                    () => AppMainButton(
                      isLoading: controller.isLoading,
                      isDefault: true,
                      onTap: controller.areFilled.value
                          ? () {
                              controller.addAddress(context);
                            }
                          : null,
                      text: tSubmit,
                    ),
                  )
                ],
              ),
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
