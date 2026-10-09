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
                _buildHeadline(),
                Padding(
                  padding: .only(top: NumberConstant.sectionGap),
                  child: _buildCategories(context),
                ),
                Padding(
                  padding: .only(top: NumberConstant.homeSectionGap),
                  child: _buildTopCollection(context),
                ),
                Padding(
                  padding: .only(top: NumberConstant.homeSectionGap),
                  child: _buildBestArtist(context),
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
          //homeHeadlineAccent, accentGreen
          //homeHeadlineSuffix, homeHeadline
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
            child: DecoratedBox(
              decoration: BoxDecoration(
               /* color: isActive ? AppColors.primaryGreen : AppColors.greyLight,
                borderRadius: .circular(NumberConstant.chipRadius),
                border: .all(color: AppColors.greyNormal),*/
              ),
              child: Padding(
                padding: .symmetric(
                  horizontal:  NumberConstant.chipHorizontalPadding,
                  vertical: NumberConstant.chipVerticalPadding,
                ),

                //category, isActive, chipActive, chipInactive
                child: const SizedBox(),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        //title, sectionTitle,
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
          ClipRRect(
            borderRadius: .vertical(top: .circular(NumberConstant.cardRadius)),
            //nft.image, height: collectionCardImgHeight, fit.cover
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: .vertical(bottom: .circular(NumberConstant.cardRadius)),
              /*boxShadow: [
                BoxShadow(
                  color: AppColors.darkLighter.withValues(alpha: 0.1),
                  blurRadius: NumberConstant.collectionCardShadowBlur,
                  spreadRadius: 0,
                  offset: const Offset(0, 5),
                ),
              ],*/
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
                          Expanded(child: const SizedBox()),
                          Column(
                            spacing: NumberConstant.microGap,
                            crossAxisAlignment: .end,
                            children: [
                              //endsIn, caption
                              Row(
                                spacing: NumberConstant.smallGap,
                                children: [
                                  //icClock
                                  //nft.endsIn
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      // const DashedDivider(),
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
                                //nft.priceEth, labelMedium
                              ],
                            ),
                          ],
                        ),
                      ),
                      //PrimaryButton: label-placeBid, icon:icBid, onTap, detail.routeName

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
        // _buildSectionHeader(StringConst.bestArtist),
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
                ClipOval(
                  //artist.avatar, widthHeight: avatarSize, fit.cover
                  child: const SizedBox()
                ),
                Expanded(
                  child: Column(
                    spacing: NumberConstant.microGap,
                    crossAxisAlignment: .start,
                    children: [
                      //artist.name, labelMedium,
                      //artist.followers, caption
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
       /* PrimaryButton(
          label: StringConst.follow,
          variant: .green,
          padding: .symmetric(
            horizontal: NumberConstant.followButtonHorizontalPadding,
            vertical: NumberConstant.buttonVerticalPadding,
          ),
          onTap: () => context.push(NamedRoutes.collection.routeName),
        ),*/
      ],
    );
  }
}
