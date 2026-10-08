import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nft_market_app_ui/constants/number_constant.dart';
import 'package:nft_market_app_ui/core/app_colors.dart';
import 'package:nft_market_app_ui/core/app_textstyles.dart';

enum PrimaryButtonVariant { dark, green }

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final String? icon;
  final PrimaryButtonVariant variant;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final TextStyle? textStyle;
  final double iconGap;
  final ColorFilter? iconColorFilter;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.variant = .dark,
    this.padding,
    this.width,
    this.textStyle,
    this.iconGap = NumberConstant.placeBidIconGap,
    this.iconColorFilter,
  });

  @override
  Widget build(BuildContext context) {
    final isGreen = variant == .green;
    final background = isGreen ? AppColors.primaryGreen : AppColors.darkNormal;
    final style = textStyle ?? AppTextStyles.buttonWhite;
    final content = Row(
      mainAxisSize: .min,
      mainAxisAlignment: .center,
      spacing: iconGap,
      children: [
        if (icon != null)
          SvgPicture.asset(
            icon!,
            colorFilter: iconColorFilter ?? .mode(AppColors.whiteColor, .srcIn),
          ),
        Text(label, style: style),
      ],
    );

    return GestureDetector(
      onTap: onTap,
      behavior: .opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          borderRadius: .circular(NumberConstant.buttonRadius),
        ),
        child: SizedBox(
          width: width,
          child: Padding(
            padding: padding ??
                .symmetric(
                  horizontal: NumberConstant.buttonHorizontalPadding,
                  vertical: NumberConstant.buttonVerticalPadding,
                ),
            child: width == null ? content : Center(child: content),
          ),
        ),
      ),
    );
  }
}
