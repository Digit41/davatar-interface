import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppButton extends StatelessWidget {
  String title;
  GestureTapCallback? onTap;
  Widget? icon;

  AppButton({required this.title, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Get.theme.primaryColor),
        backgroundColor: MaterialStateProperty.all(
          Get.theme.primaryColor.withOpacity(0.1),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null) const SizedBox(width: 4.0),
            Text(title, style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
