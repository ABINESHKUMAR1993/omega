import 'package:flutter/material.dart';
import 'package:omiga_ipl/constants/main_colors.dart';

class SquareButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final bool isBack;

  const SquareButton({
    super.key,
    this.onTap,
    required this.icon,
    this.isBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: cPrimaryColor.withOpacity(.1),
              offset: Offset.zero,
              blurRadius: 8,
              spreadRadius: 0.001,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: cBlue,
            size: 24,
          ),
        ),
      ),
    );
  }
}
