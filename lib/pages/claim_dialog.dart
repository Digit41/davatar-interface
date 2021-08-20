import 'package:dapp/utils/app_theme.dart';
import 'package:dapp/utils/strings.dart';
import 'package:dapp/utils/utils.dart';
import 'package:dapp/widgets/app_button.dart';
import 'package:dapp/widgets/app_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void claimDialog() {
  AppTextFormField addressOrENS = AppTextFormField(
    hint: Strings.WALLET_ADDER_ENS.tr,
    autoValidateMode: false,
  );

  addressOrENS.suffixIcon = pasteSuffix(addressOrENS.controller);

  Get.dialog(
    SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      children: [
        SizedBox(
          width: 360.0,
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
                    const SizedBox(height: 12.0),
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(Strings.DESC_CLAIM_DIALOG.tr),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: darkModeEnabled()
                      ? Colors.grey.shade900
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: addressOrENS,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                child: SizedBox(
                  height: 50.0,
                  child: AppButton(
                    title: Strings.CLAIM.tr + ' DIGIT41',
                    onTap: addressOrENS.controller.text == '' ? null : () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
