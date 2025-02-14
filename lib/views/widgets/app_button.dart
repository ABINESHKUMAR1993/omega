import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';

class AppMainButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool isDefault;
  final RxBool isLoading;


  const AppMainButton({
    super.key,
    this.onTap,
    required this.text, required this.isDefault, required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: cPrimaryColor),
          color: isDefault?cPrimaryColor:Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child:isLoading.value?Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.5,
              ),
            ),
            const SizedBox(width: 15,),

            Text(
              "Loading...",
              style: TextHelper.pop14W500W,
            )
          ],
        ): Center(
          child: Text(
            text,
            style:isDefault? TextHelper.pop16W500W:TextHelper.pop16W500P,
          ),
        ),
      ),
    );
  }
}
