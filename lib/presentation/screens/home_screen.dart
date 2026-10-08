import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_market_app_ui/constants/string_const.dart';
import 'package:nft_market_app_ui/core/app_textstyles.dart';
import 'package:nft_market_app_ui/presentation/providers/home_provider.dart';
import 'package:nft_market_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      builder: (context, _) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            spacing: 16,
            children: [
              Text(StringConst.home, style: AppTextStyles.sectionTitle),
              TextButton(
                onPressed: () => context.push(NamedRoutes.detail.routeName),
                child: Text(StringConst.detail, style: AppTextStyles.labelMedium),
              ),
              TextButton(
                onPressed: () => context.push(NamedRoutes.collection.routeName),
                child: Text(StringConst.collection, style: AppTextStyles.labelMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
