import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_market_app_ui/constants/number_constant.dart';
import 'package:nft_market_app_ui/core/app_colors.dart';
import 'package:nft_market_app_ui/core/asset_res.dart';

class MainShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkLighter.withValues(alpha: 0.14),
            blurRadius: NumberConstant.bottomBarShadowBlur,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: .fromLTRB(
            NumberConstant.horizontalPadding,
            NumberConstant.bottomNavTopPadding,
            NumberConstant.horizontalPadding,
            NumberConstant.smallGap,
          ),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              _buildNavItem(AssetRes.icHome, 0),
              _buildNavItem(AssetRes.icSearch, 1),
              _buildNavItem(AssetRes.icBookmark, 2),
              _buildNavItem(AssetRes.icProfile, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, int index) {
    final isSelected = navigationShell.currentIndex == index;
    return GestureDetector(
      onTap: () => navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
      behavior: .opaque,
      child: Padding(
        padding: .all(NumberConstant.microGap),
        child: SvgPicture.asset(
          icon,
          colorFilter: .mode(isSelected ? AppColors.darkNormal : AppColors.darkLighter, .srcIn),
        ),
      ),
    );
  }
}
