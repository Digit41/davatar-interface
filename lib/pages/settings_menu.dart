import 'package:dapp/pages/claim_dialog.dart';
import 'package:dapp/utils/app_shared_preferences.dart';
import 'package:dapp/utils/app_theme.dart';
import 'package:dapp/utils/strings.dart';
import 'package:dapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsMenu extends StatefulWidget {
  bool? _isConnected;

  SettingsMenu(this._isConnected);

  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  AppSharedPreferences pref = AppSharedPreferences();
  late bool darkMode;

  @override
  void initState() {
    super.initState();
    darkMode = darkModeEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          anyItem(
            Strings.ABOUT.tr,
            Icons.info_outline,
            () {},
          ),
          anyItem(
            Strings.DOCS.tr,
            Icons.menu_book_outlined,
            () {},
          ),
          anyItem(
            Strings.DISCORD.tr,
            Icons.messenger_rounded,
            () {},
          ),
          anyItem(
            darkMode ? Strings.LIGHT.tr : Strings.DARK.tr,
            Icons.wb_sunny_outlined,
            changeTheme,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 16.0),
            child: claim(),
          ),
        ],
      ),
    );
  }

  Widget anyItem(String title, IconData icon, GestureTapCallback onTap) =>
      ListTile(
        title: Text(title),
        trailing: Icon(icon, size: 18.0),
        onTap: onTap,
      );

  void changeTheme() {
    setState(() {
      if (darkMode) {
        Get.changeTheme(AppTheme.light);
        Get.changeThemeMode(ThemeMode.light);
        pref.setTheme('light');
        darkMode = false;
      } else {
        Get.changeTheme(AppTheme.dark);
        Get.changeThemeMode(ThemeMode.dark);
        pref.setTheme('dark');
        darkMode = true;
      }
    });
  }

  Widget claim() => Container(
        width: 172.0,
        height: 40.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Get.theme.primaryColor,
              Get.theme.primaryColor,
              Get.theme.primaryColor.withOpacity(0.7),
              AppTheme.gray.withOpacity(0.7),
              AppTheme.gray,
            ],
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: claimDialog,
            child: Center(
              child: Text(
                Strings.CLAIM.tr + ' DIGIT41',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
        ),
      );
}
