import 'package:flutter/material.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';


class CustomRow extends StatelessWidget {
  final String prefixText;
  final prefixStyle;
  final String suffixText;
  final suffixStyle;
  final bool isBox;
  const CustomRow(
      {super.key,
      required this.prefixText,
      required this.suffixText,
      this.prefixStyle,
      this.suffixStyle,
      required this.isBox});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: isBox?Text(
            prefixText,
            style: TextHelper.pop14W400B,
            textAlign: TextAlign.start,
          ):Text(
            prefixText,
            style: prefixStyle,
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          child:isBox? Text(
            suffixText,
            style: TextHelper.pop14W400G,
            textAlign: TextAlign.end,
          ):Text(
            suffixText,
            style: suffixStyle,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
