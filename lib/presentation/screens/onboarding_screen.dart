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
import 'package:nft_market_app_ui/presentation/widgets/fade_slide_in.dart';
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
                FadeSlideIn(
                  duration: const Duration(milliseconds: NumberConstant.animSlowMs),
                  child: _buildHero(context),
                ),
                Expanded(
                  child: Padding(
                    padding: .symmetric(horizontal: NumberConstant.horizontalPadding),
                    child: Column(
                      children: [
                        Padding(
                          padding: .only(top: NumberConstant.onboardingTextTopGap),
                          child: FadeSlideIn(
                            delay: const Duration(milliseconds: NumberConstant.animStaggerMs),
                            child: _buildTextContent(context),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: .only(bottom: NumberConstant.onboardingBottomPadding),
                          child: SafeArea(
                            top: false,
                            child: FadeSlideIn(
                              delay: const Duration(milliseconds: NumberConstant.animStaggerMs * 2),
                              child: _buildBottomActions(context),
                            ),
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
          const Align(
            alignment: .topLeft,
            child: _BreathingHeroImage(),
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

  Widget _buildTextContent(BuildContext context) {
    final pageIndex = context.watch<OnboardingProvider>().pageIndex;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: NumberConstant.animNormalMs),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(begin: const Offset(0, NumberConstant.animSlideOffset), end: Offset.zero).animate(animation),
          child: child,
        ),
      ),
      child: Column(
        key: ValueKey(pageIndex),
        spacing: NumberConstant.onboardingTitleSubtitleGap,
        children: [
          _buildTitle(),
          Text(StringConst.onboardingSubtitle, style: AppTextStyles.bodyLight, textAlign: .center),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(StringConst.onboardingTitlePrefix.trimRight(), style: AppTextStyles.onboardingTitle, textAlign: .center),
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
        return AnimatedContainer(
          duration: const Duration(milliseconds: NumberConstant.animFastMs),
          curve: Curves.easeOutCubic,
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.darkNormal.withValues(alpha: isActive ? 1 : 0.3),
            borderRadius: .circular(NumberConstant.buttonRadius),
          ),
        );
      }),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final isPressed = context.watch<OnboardingProvider>().isNextPressed;
    return GestureDetector(
      onTapDown: (_) => context.read<OnboardingProvider>().setNextPressed(true),
      onTapUp: (_) => context.read<OnboardingProvider>().setNextPressed(false),
      onTapCancel: () => context.read<OnboardingProvider>().setNextPressed(false),
      onTap: () => _onNext(context),
      behavior: .opaque,
      child: AnimatedScale(
        scale: isPressed ? NumberConstant.animPressScale : 1,
        duration: const Duration(milliseconds: NumberConstant.animFastMs),
        curve: Curves.easeOutCubic,
        child: DecoratedBox(
          decoration: const BoxDecoration(color: AppColors.darkNormal, shape: .circle),
          child: Padding(
            padding: .all(NumberConstant.circularActionPadding),
            child: SvgPicture.asset(AssetRes.icArrowNext),
          ),
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

class _BreathingHeroImage extends StatefulWidget {
  const _BreathingHeroImage();

  @override
  State<_BreathingHeroImage> createState() => _BreathingHeroImageState();
}

class _BreathingHeroImageState extends State<_BreathingHeroImage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: NumberConstant.animBreatheMs),
    )..repeat(reverse: true);
    _scale = Tween(begin: 1.0, end: NumberConstant.animBreatheScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      alignment: .topLeft,
      child: Image.asset(AssetRes.onboardingImg, fit: .contain),
    );
  }
}
