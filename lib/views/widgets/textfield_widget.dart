import 'package:flutter/material.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final Widget? prefix;
  final bool obscureText;
  final bool showSuffixIcon;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final int? maxLine;

  const CustomTextField(
      {super.key,
      this.controller,
      required this.hintText,
      this.validator,
      this.keyboardType,
      this.suffix,
      this.prefix,
      required this.obscureText,
      required this.readOnly,
      this.onChanged,
      this.onTap,
      this.maxLine,
      required this.showSuffixIcon});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onTap: widget.onTap,
        maxLines: widget.maxLine ?? 1,
        style: TextHelper.pop14W400B,
        readOnly: widget.readOnly,
        onChanged: widget.onChanged,
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        decoration: InputDecoration(
          prefixIcon: widget.prefix,
          suffixIcon: widget.showSuffixIcon
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: cBlue,
                  ),
                )
              : null,
          prefixIconColor: Colors.white,
          isDense: false,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          constraints: const BoxConstraints(minHeight: 50, maxHeight: 100),
          hintText: widget.hintText,
          errorStyle: const TextStyle(
            color: cRed,
            fontFamily: "Poppins",
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: TextHelper.pop14W400G,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: cBlue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: cBlue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: cBlue),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: cBlue),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: cBlue),
          ),
        ),
      ),
    );
  }
}
