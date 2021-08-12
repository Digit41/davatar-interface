import 'package:dapp/pages/home.dart';
import 'package:dapp/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/app_shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String? theme;

  Future<bool> _initTheme() async {
    if (theme == null) {
      AppSharedPreferences pref = AppSharedPreferences();
      theme = await pref.getTheme() ?? 'system';
      if (theme == 'light') {
        Get.changeTheme(AppTheme.light);
        Get.changeThemeMode(ThemeMode.light);
      } else if (theme == 'dark') {
        Get.changeTheme(AppTheme.dark);
        Get.changeThemeMode(ThemeMode.dark);
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initTheme(),
      builder: (ctx, snapData) => snapData.hasData
          ? GetMaterialApp(
              title: 'DApp',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              home: Home(),
            )
          : Center(),
    );
  }
}
