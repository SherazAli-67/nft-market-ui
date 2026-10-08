import 'package:flutter/material.dart';
import 'package:nft_market_app_ui/constants/string_const.dart';
import 'package:nft_market_app_ui/core/app_colors.dart';
import 'package:nft_market_app_ui/routing/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .light,
        fontFamily: StringConst.appFontFamily,
        scaffoldBackgroundColor: AppColors.whiteColor,
        colorScheme: .light(
          primary: AppColors.primaryGreen,
          onPrimary: AppColors.whiteColor,
          surface: AppColors.whiteColor,
          onSurface: AppColors.darkNormal,
        ),
      ),
      builder: (ctx, child) => child!,
      routerConfig: router,
    );
  }
}
