import 'package:flutter/material.dart';
import 'package:omiga_ipl/constants/main_colors.dart';

class RefreshWidget extends StatelessWidget {
  String msg;
  final VoidCallback? onTap;
  RefreshWidget({super.key, this.onTap, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(msg),
        TextButton.icon(
          onPressed: onTap,
          icon: const Icon(
            Icons.refresh,
            color: cPrimaryColor,
          ),
          label: const Text(
            "Refresh",
            style: TextStyle(color: cPrimaryColor),
          ),
        )
      ],
    ));
  }
}
