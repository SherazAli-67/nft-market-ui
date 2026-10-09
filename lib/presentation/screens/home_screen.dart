import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_market_app_ui/constants/number_constant.dart';
import 'package:nft_market_app_ui/constants/string_const.dart';
import 'package:nft_market_app_ui/core/app_colors.dart';
import 'package:nft_market_app_ui/core/app_data.dart';
import 'package:nft_market_app_ui/core/app_textstyles.dart';
import 'package:nft_market_app_ui/core/asset_res.dart';
import 'package:nft_market_app_ui/core/models/artist_model.dart';
import 'package:nft_market_app_ui/core/models/nft_model.dart';
import 'package:nft_market_app_ui/presentation/providers/home_provider.dart';
import 'package:nft_market_app_ui/presentation/widgets/dashed_divider.dart';
import 'package:nft_market_app_ui/presentation/widgets/fade_slide_in.dart';
import 'package:nft_market_app_ui/presentation/widgets/primary_button.dart';
import 'package:nft_market_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      builder: (context, _) => Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: .symmetric(horizontal: NumberConstant.horizontalPadding, vertical: NumberConstant.verticalPadding),
            child: ListView(
              padding: .only(bottom: NumberConstant.homeListBottomPadding),
              children: [
                FadeSlideIn(child: _buildHeadline()),
                Padding(
                  padding: .only(top: NumberConstant.sectionGap),
                  child: FadeSlideIn(
                    delay: const Duration(milliseconds: NumberConstant.animStaggerMs),
                    child: _buildCategories(context),
                  ),
                ),
                Padding(
                  padding: .only(top: NumberConstant.homeSectionGap),
                  child: FadeSlideIn(
                    delay: const Duration(milliseconds: NumberConstant.animStaggerMs * 2),
                    child: _buildTopCollection(context),
                  ),
                ),
                Padding(
                  padding: .only(top: NumberConstant.homeSectionGap),
                  child: FadeSlideIn(
                    delay: const Duration(milliseconds: NumberConstant.animStaggerMs * 3),
                    child: _buildBestArtist(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeadline() {
    return Text.rich(
      TextSpan(
        children: [
          //homeHeadlinePrefix, homeHeadline
          TextSpan(text: StringConst.homeHeadlinePrefix, style: AppTextStyles.homeHeadline),
          //homeHeadlineAccent, accentGreen
          TextSpan(text: StringConst.homeHeadlineAccent, style: AppTextStyles.accentGreen),
          //homeHeadlineSuffix, homeHeadline
          TextSpan(text: StringConst.homeHeadlineSuffix, style: AppTextStyles.homeHeadline)
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final selectedIndex = context.watch<HomeProvider>().selectedCategoryIndex;
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Row(
        spacing: NumberConstant.chipGap,
        children: List.generate(AppData.categories.length, (index) {
          final isActive = index == selectedIndex;
          String category = AppData.categories[index];
          return GestureDetector(
            onTap: () => context.read<HomeProvider>().selectCategory(index),
            behavior: .opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: NumberConstant.animFastMs),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryGreen : AppColors.greyLight,
                borderRadius: .circular(NumberConstant.chipRadius),
                border: .all(color: AppColors.greyNormal),
              ),
              padding: .symmetric(
                horizontal: isActive
                    ? NumberConstant.chipHorizontalPadding
                    : NumberConstant.chipHorizontalPaddingInactive,
                vertical: NumberConstant.chipVerticalPadding,
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: NumberConstant.animFastMs),
                curve: Curves.easeOutCubic,
                style: isActive ? AppTextStyles.chipActive : AppTextStyles.chipInactive,
                child: Text(category),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        //title, sectionTitle,
        Text(title, style: AppTextStyles.sectionTitle,),
        SvgPicture.asset(AssetRes.icMore)
        //icMore
      ],
    );
  }

  Widget _buildTopCollection(BuildContext context) {
    final nft = AppData.topCollection;
    return Column(
      spacing: NumberConstant.chipGap,
      children: [
        _buildSectionHeader(StringConst.topCollection),
        _buildCollectionCard(context, nft),
      ],
    );
  }

  Widget _buildCollectionCard(BuildContext context, NftModel nft) {
    return GestureDetector(
      onTap: () => context.push(NamedRoutes.detail.routeName),
      behavior: .opaque,
      child: Column(
        children: [
          Hero(
            tag: nft.id,
            child: ClipRRect(
              borderRadius: .vertical(top: .circular(NumberConstant.cardRadius)),
              child: Image.asset(nft.image, height: NumberConstant.collectionCardImageHeight, fit: .cover, width: .infinity),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: .vertical(bottom: .circular(NumberConstant.cardRadius)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkLighter.withValues(alpha: 0.1),
                  blurRadius: NumberConstant.collectionCardShadowBlur,
                  spreadRadius: 0,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: .all(NumberConstant.collectionCardPadding),
              child: Column(
                spacing: NumberConstant.sectionGap,
                children: [
                  Column(
                    spacing: NumberConstant.contentGap,
                    children: [
                      Row(
                        children: [
                          //nft.name, bodyMedium
                          
                          Expanded(child: Text(nft.name, style: AppTextStyles.bodyMedium,)),
                          Column(
                            spacing: NumberConstant.microGap,
                            crossAxisAlignment: .end,
                            children: [
                              //endsIn, caption
                              Text(StringConst.endsIn, style: AppTextStyles.caption,),
                              Row(
                                spacing: NumberConstant.smallGap,
                                children: [
                                  //icClock
                                  SvgPicture.asset(AssetRes.icClock),
                                  //nft.endsIn
                                  Text(nft.endsIn)
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const DashedDivider(),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: NumberConstant.microGap,
                          crossAxisAlignment: .start,
                          children: [
                            //highestBiddingToday, caption
                            Row(
                              spacing: NumberConstant.microGap,
                              children: [
                                //icEth
                                SvgPicture.asset(AssetRes.icEth),
                                Text(nft.priceEth, style: AppTextStyles.labelMedium,)
                                //nft.priceEth, labelMedium
                              ],
                            ),
                          ],
                        ),
                      ),
                      //PrimaryButton: label-placeBid, icon:icBid, onTap, detail.routeName
                      PrimaryButton(label: StringConst.placeBid, icon: AssetRes.icBid, onTap: ()=> context.push(NamedRoutes.detail.routeName),)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestArtist(BuildContext context) {
    final artist = AppData.bestArtist;
    return Column(
      spacing: NumberConstant.sectionGap,
      children: [
        _buildSectionHeader(StringConst.bestArtist),
        _buildArtistRow(context, artist),
      ],
    );
  }

  Widget _buildArtistRow(BuildContext context, ArtistModel artist) {
    return Row(
      spacing: NumberConstant.artistRowGap,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => context.push(NamedRoutes.collection.routeName),
            behavior: .opaque,
            child: Row(
              spacing: NumberConstant.artistInfoGap,
              children: [
                Hero(
                  tag: artist.name,
                  child: ClipOval(
                    child: Image.asset(artist.avatar, width: NumberConstant.avatarSize, height: NumberConstant.avatarSize, fit: .cover),
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: NumberConstant.microGap,
                    crossAxisAlignment: .start,
                    children: [
                      //artist.name, labelMedium,
                      Text(artist.name, style: AppTextStyles.labelMedium,),
                      Text(artist.followers, style: AppTextStyles.caption,)
                      //artist.followers, caption
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        PrimaryButton(
          label: StringConst.follow,
          variant: .green,
          padding: .symmetric(
            horizontal: NumberConstant.followButtonHorizontalPadding,
            vertical: NumberConstant.buttonVerticalPadding,
          ),
          onTap: () => context.push(NamedRoutes.collection.routeName),
        ),
      ],
    );
  }
}
