import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/models/address_model.dart';
import 'package:omiga_ipl/views/screens/adress_screen.dart';
import 'package:omiga_ipl/views/widgets/app_button.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  AddressModel? addressData;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppbar(
            title: tMyAdrs,
            isBack: true,
          )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppMainButton(
              isLoading: false.obs,
              isDefault: false,
              onTap: () {
                Get.to(AddressScreen(
                  isShow: false,
                ));
              },
              text: tAddAdrs,
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: NetworkHelper().getAddress(context: context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  addressData = snapshot.data;
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: addressData!
                          .data.length, // Use the length of the data
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Get.to(AddressScreen(
                            houNo: addressData!.data[index].houseNo.toString(),
                            roadName:
                                addressData!.data[index].roadName.toString(),
                            landmark:
                                addressData!.data[index].landmark.toString(),
                            pin: addressData!.data[index].pin.toString(),
                            state: addressData!.data[index].state.toString(),
                            district:
                                addressData!.data[index].district.toString(),
                            isShow: true,
                          ));
                        },
                        child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 7),
                                      blurRadius: 15,
                                      spreadRadius: -2)
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: width * .5,
                                      child: RichText(
                                        softWrap: true,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    "${addressData!.data[index].landmark}\n",
                                                style: TextHelper.pop16W500B),
                                            TextSpan(
                                                text:
                                                    "${addressData!.data[index].roadName.toString()}\n",
                                                style: TextHelper.pop12W400G),
                                            TextSpan(
                                                text:
                                                    "${addressData!.data[index].district.toString()}\n",
                                                style: TextHelper.pop14W400B),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () async {
                                          // Check if it's the last address
                                          if (addressData!.data.length == 1) {
                                            Get.off(() => AddressScreen(
                                                  isShow: false,
                                                ));
                                          } else {
                                            // If there are multiple addresses, proceed with deletion
                                            await NetworkHelper()
                                                .deleteAddressApi(
                                              context: context,
                                              addId: addressData!.data[index].id
                                                  .toString(),
                                            );
                                            setState(
                                                () {}); // Rebuild the UI to reflect the change
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 18,
                                        ),
                                        color: cRed)
                                  ],
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                        onTap: () async {
                                          await NetworkHelper()
                                              .updateCurrentAddressApi(
                                                  context: context,
                                                  addId: addressData!
                                                      .data[index].id
                                                      .toString());
                                        },
                                        child: Text(
                                          tSetCrntAdrs,
                                          style: TextHelper.pop12W400P,
                                        )))
                              ],
                            )),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
