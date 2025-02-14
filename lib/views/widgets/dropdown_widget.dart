import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final RxString selectedItem;
  final String hint;
  final void Function(String?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextHelper.pop14W400G,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: cBlue)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: cBlue)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: cBlue)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: cBlue)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: cBlue)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        ),
        value: selectedItem.value.isEmpty ? null : selectedItem.value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextHelper.pop16W500B,
            ),
          );
        }).toList(),
        onChanged: (String? newItem) {
          selectedItem.value = newItem ?? '';
          if (onChanged != null) {
            onChanged!(newItem);
          }
        },
      );
    });
  }
}
