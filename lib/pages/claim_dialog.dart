import 'package:dapp/utils/app_theme.dart';
import 'package:dapp/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void claimDialog() {
  Get.dialog(
    SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      children: [
        SizedBox(
          width: 350.0,
          height: 400.0,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Get.theme.primaryColor,
                      AppTheme.gray,
                      AppTheme.gray,
                      AppTheme.gray,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.CLAIM.tr + ' DIGIT41 ' + Strings.TOKEN.tr,
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.close, color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      '0 DIGIT41',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
