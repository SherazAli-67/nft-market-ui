import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_market_app_ui/constants/number_constant.dart';
import 'package:nft_market_app_ui/constants/string_const.dart';
import 'package:nft_market_app_ui/core/app_colors.dart';
import 'package:nft_market_app_ui/core/app_textstyles.dart';
import 'package:nft_market_app_ui/core/asset_res.dart';
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
        backgroundColor: AppColors.whiteColor,
        body: Stack(
          children: [
            Positioned(
              left: NumberConstant.horizontalPadding * 0.6,
              bottom: 120,
              child: _buildGlow(95, 0.15),
            ),
            Positioned(
              right: NumberConstant.horizontalPadding * 1.5,
              bottom: 80,
              child: _buildGlow(95, 0.15),
            ),
            Column(
              children: [
                _buildHero(context),
                Expanded(
                  child: Padding(
                    padding: .symmetric(horizontal: NumberConstant.horizontalPadding),
                    child: Column(
                      children: [
                        Padding(
                          padding: .only(top: NumberConstant.onboardingTextTopGap),
                          child: _buildTextContent(),
                        ),
                        const Spacer(),
                        Padding(
                          padding: .only(bottom: NumberConstant.onboardingBottomPadding),
                          child: SafeArea(
                            top: false,
                            child: _buildBottomActions(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlow(double size, double opacity) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.primaryGreen.withValues(alpha: opacity),
          shape: .circle,
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return SizedBox(
      height: NumberConstant.onboardingImageHeight,
      width: double.infinity,
      child: Stack(
        children: [
          const ColoredBox(color: AppColors.greenLight, child: SizedBox.expand()),
          Positioned(
            top: 28,
            right: 16,
            child: _buildGlow(163, 0.1),
          ),
          Align(
            alignment: .topLeft,
            child:  Image.asset(AssetRes.onboardingImg, fit: .contain),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: NumberConstant.onboardingHeroFadeHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [
                    AppColors.whiteColor.withValues(alpha: 0),
                    AppColors.whiteColor,
                  ],
                  stops: const [0.35, 1],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Align(
              alignment: .topRight,
              child: GestureDetector(
                onTap: () => context.go(NamedRoutes.home.routeName),
                behavior: .opaque,
                child: Padding(
                  padding: .fromLTRB(
                    NumberConstant.horizontalPadding,
                    NumberConstant.onboardingSkipTop,
                    NumberConstant.horizontalPadding,
                    NumberConstant.smallGap,
                  ),
                  child: Text(StringConst.skip, style: AppTextStyles.labelMedium),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      spacing: NumberConstant.onboardingTitleSubtitleGap,
      children: [
        _buildTitle(),
        Text(
          StringConst.onboardingSubtitle,
          style: AppTextStyles.bodyLight,
          textAlign: .center,
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          StringConst.onboardingTitlePrefix.trimRight(),
          style: AppTextStyles.onboardingTitle,
          textAlign: .center,
        ),
        Stack(
          clipBehavior: .none,
          alignment: .center,
          children: [
            Text(StringConst.onboardingTitleAccent, style: AppTextStyles.accentGreenLarge, textAlign: .center),
            Positioned(
              left: 0,
              right: 0,
              bottom: -NumberConstant.microGap,
              child: Transform.rotate(
                angle: NumberConstant.underlineRotation,
                child: SvgPicture.asset(AssetRes.icNftUnderline),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    final pageIndex = context.watch<OnboardingProvider>().pageIndex;
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        _buildPageIndicators(pageIndex),
        _buildNextButton(context),
      ],
    );
  }

  Widget _buildPageIndicators(int pageIndex) {
    return Row(
      spacing: NumberConstant.onboardingDotGap,
      children: List.generate(NumberConstant.onboardingPageCount, (index) {
        final isActive = index == pageIndex;
        final size = isActive ? NumberConstant.onboardingActiveDotSize : NumberConstant.onboardingDotSize;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.darkNormal.withValues(alpha: isActive ? 1 : 0.3),
            borderRadius: .circular(NumberConstant.buttonRadius),
          ),
          child: SizedBox(width: size, height: size),
        );
      }),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _onNext(context),
      behavior: .opaque,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.darkNormal,
          shape: .circle,
        ),
        child: Padding(
          padding: .all(NumberConstant.circularActionPadding),
          child: SvgPicture.asset(AssetRes.icArrowNext),
        ),
      ),
    );
  }

  void _onNext(BuildContext context) {
    final provider = context.read<OnboardingProvider>();
    if (provider.pageIndex >= NumberConstant.onboardingPageCount - 1) {
      context.go(NamedRoutes.home.routeName);
      return;
    }
    provider.nextPage(pageCount: NumberConstant.onboardingPageCount);
  }
}
