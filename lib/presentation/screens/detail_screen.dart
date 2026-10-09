import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nft_market_app_ui/constants/number_constant.dart';
import 'package:nft_market_app_ui/constants/string_const.dart';
import 'package:nft_market_app_ui/core/app_colors.dart';
import 'package:nft_market_app_ui/core/app_data.dart';
import 'package:nft_market_app_ui/core/app_textstyles.dart';
import 'package:nft_market_app_ui/core/asset_res.dart';
import 'package:nft_market_app_ui/core/models/nft_model.dart';
import 'package:nft_market_app_ui/presentation/widgets/app_back_button.dart';
import 'package:nft_market_app_ui/presentation/widgets/dashed_divider.dart';
import 'package:nft_market_app_ui/presentation/widgets/primary_button.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nft = AppData.featuredNft;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: .symmetric(horizontal: NumberConstant.horizontalPadding, vertical: NumberConstant.verticalPadding),
                child: Column(
                  spacing: NumberConstant.homeSectionGap,
                  children: [
                    _buildNavigation(),
                    Expanded(
                      child: ListView(
                        padding: .only(bottom: NumberConstant.sectionGap),
                        children: [
                          _buildImage(nft),
                          Padding(
                            padding: .only(top: NumberConstant.homeSectionGap),
                            child: _buildProductInfo(nft),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomBar(nft),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigation() {
    return Row(
      children: [
        const AppBackButton(),
        Expanded(
          child: Text(StringConst.detail, style: AppTextStyles.appBarTitle, textAlign: .center),
        ),
        const Opacity(opacity: 0, child: AppBackButton()),
      ],
    );
  }

  Widget _buildImage(NftModel nft) {
    return ClipRRect(
      borderRadius: .circular(NumberConstant.imageRadius),
      child: Image.asset(
        nft.image,
        height: NumberConstant.detailImageHeight,
        width: double.infinity,
        fit: .cover,
      ),
    );
  }

  Widget _buildProductInfo(NftModel nft) {
    return Column(
      spacing: NumberConstant.contentGap,
      crossAxisAlignment: .start,
      children: [
        Column(
          spacing: NumberConstant.contentGap,
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    spacing: NumberConstant.smallGap,
                    crossAxisAlignment: .start,
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(nft.id, style: AppTextStyles.nftId),
                          Text(
                            nft.name,
                            style: AppTextStyles.detailTitle.copyWith(fontWeight: .w500),
                          ),
                        ],
                      ),
                      Row(
                        spacing: NumberConstant.smallGap,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.greenLight.withValues(alpha: 0.35),
                              borderRadius: .circular(NumberConstant.buttonRadius),
                            ),
                            child: Padding(
                              padding: .symmetric(
                                horizontal: NumberConstant.soldChipHorizontalPadding,
                                vertical: NumberConstant.soldChipVerticalPadding,
                              ),
                              child: Text('${nft.sold}${StringConst.soldSuffix}', style: AppTextStyles.microLabel),
                            ),
                          ),
                          Row(
                            spacing: NumberConstant.microGap,
                            children: [
                              SvgPicture.asset(AssetRes.icClock),
                              Text(nft.endsIn, style: AppTextStyles.microLabel),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildCrownBadge(),
              ],
            ),
            const DashedDivider(),
          ],
        ),
        Column(
          spacing: NumberConstant.smallGap,
          crossAxisAlignment: .start,
          children: [
            Text(StringConst.description, style: AppTextStyles.sectionTitle),
            Text(nft.description, style: AppTextStyles.description),
          ],
        ),
      ],
    );
  }

  Widget _buildCrownBadge() {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.greyLight,
        shape: .circle,
      ),
      child: Padding(
        padding: .all(NumberConstant.crownBadgePadding),
        child: SvgPicture.asset(AssetRes.icCrown, colorFilter: .mode(AppColors.darkNormal, .srcIn)),
      ),
    );
  }

  Widget _buildBottomBar(NftModel nft) {
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
            NumberConstant.collectionCardPadding,
            NumberConstant.horizontalPadding,
            NumberConstant.smallGap,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  spacing: NumberConstant.microGap,
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Text(StringConst.price, style: AppTextStyles.labelRegular),
                    Text(nft.priceEth, style: AppTextStyles.priceValue),
                  ],
                ),
              ),
              PrimaryButton(
                label: StringConst.placeBid,
                icon: AssetRes.icBid,
                width: NumberConstant.detailBidButtonWidth,
                padding: .all(NumberConstant.detailBidButtonPadding),
                iconGap: NumberConstant.contentGap,
                textStyle: AppTextStyles.buttonWhiteLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
