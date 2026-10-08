import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_market_app_ui/constants/number_constant.dart';
import 'package:nft_market_app_ui/core/app_colors.dart';
import 'package:nft_market_app_ui/core/asset_res.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AppBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => context.pop(),
      behavior: .opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.greenLight.withValues(alpha: 0.35),
          shape: .circle,
        ),
        child: Padding(
          padding: .all(NumberConstant.backButtonPadding),
          child: SvgPicture.asset(AssetRes.icArrowBack, colorFilter: .mode(AppColors.darkNormal, .srcIn)),
        ),
      ),
    );
  }
}
