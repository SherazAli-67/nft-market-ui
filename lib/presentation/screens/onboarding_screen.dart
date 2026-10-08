import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_market_app_ui/constants/string_const.dart';
import 'package:nft_market_app_ui/core/app_textstyles.dart';
import 'package:nft_market_app_ui/presentation/providers/onboarding_provider.dart';
import 'package:nft_market_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider(),
      builder: (context, _) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            spacing: 16,
            children: [
              Text(StringConst.onboardingTitleAccent, style: AppTextStyles.sectionTitle),
              TextButton(
                onPressed: () => context.go(NamedRoutes.home.routeName),
                child: Text(StringConst.skip, style: AppTextStyles.labelMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
