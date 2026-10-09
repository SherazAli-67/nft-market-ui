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
import 'package:nft_market_app_ui/presentation/providers/collection_provider.dart';
import 'package:nft_market_app_ui/presentation/widgets/app_back_button.dart';
import 'package:nft_market_app_ui/presentation/widgets/primary_button.dart';
import 'package:nft_market_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CollectionProvider(),
      builder: (context, _) {
        final artist = AppData.bestArtist;
        final tabIndex = context.watch<CollectionProvider>().selectedTabIndex;
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: SafeArea(
            child: Padding(
              padding: .symmetric(horizontal: NumberConstant.horizontalPadding, vertical: NumberConstant.verticalPadding),
              child: Column(
                spacing: NumberConstant.homeSectionGap,
                children: [
                  _buildNavigation(),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(child: _buildProfileHeader(context, artist)),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: .only(top: NumberConstant.profileSectionGap),
                            child: _buildTabs(context, tabIndex),
                          ),
                        ),
                        if (tabIndex == 0)
                          SliverPadding(
                                            padding: .only(top: NumberConstant.homeSectionGap, bottom: NumberConstant.homeListBottomPadding),
                            sliver: SliverGrid(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: NumberConstant.gridCrossAxisSpacing,
                                mainAxisSpacing: NumberConstant.gridMainAxisSpacing,
                                mainAxisExtent: NumberConstant.gridItemHeight,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => _buildGridItem(context, AppData.collectionItems[index]),
                                childCount: AppData.collectionItems.length,
                              ),
                            ),
                          )
                        else
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: .only(top: NumberConstant.homeSectionGap, bottom: NumberConstant.homeListBottomPadding),
                              child: Center(child: Text(StringConst.activityPlaceholder, style: AppTextStyles.description)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigation() {
    return Row(
      children: [
        const AppBackButton(),
        Expanded(
          child: Text(StringConst.collection, style: AppTextStyles.appBarTitle, textAlign: .center),
        ),
        const Opacity(opacity: 0, child: AppBackButton()),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context, ArtistModel artist) {
    return Column(
      spacing: NumberConstant.profileDetailGap,
      children: [
        Column(
          spacing: NumberConstant.smallGap,
          children: [
            _buildBannerAvatar(artist),
            Column(
              spacing: NumberConstant.profileDetailGap,
              children: [
                Column(
                  spacing: NumberConstant.microGap,
                  children: [
                    Row(
                      mainAxisAlignment: .center,
                      mainAxisSize: .min,
                      children: [
                        Text(artist.name, style: AppTextStyles.artistName, textAlign: .center),
                        if (artist.isVerified) SvgPicture.asset(AssetRes.icVerified),
                      ],
                    ),
                    Text(artist.bio, style: AppTextStyles.description, textAlign: .center),
                  ],
                ),
                _buildStats(artist),
              ],
            ),
          ],
        ),
        _buildWatchlistRow(context),
      ],
    );
  }

  Widget _buildBannerAvatar(ArtistModel artist) {
    return SizedBox(
      height: NumberConstant.bannerHeight + NumberConstant.bannerAvatarOverlap,
      width: double.infinity,
      child: Stack(
        alignment: .topCenter,
        children: [
          ClipRRect(
            borderRadius: .circular(NumberConstant.gridItemRadius),
            child: Image.asset(
              artist.banner,
              height: NumberConstant.bannerHeight,
              width: double.infinity,
              fit: .cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: .circle,
                border: .all(color: AppColors.greenLight, width: NumberConstant.artistAvatarBorderWidth),
              ),
              child: ClipOval(
                child: Image.asset(
                  artist.avatar,
                  width: NumberConstant.artistAvatarSize,
                  height: NumberConstant.artistAvatarSize,
                  fit: .cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(ArtistModel artist) {
    return Row(
      mainAxisAlignment: .center,
      spacing: NumberConstant.statsGap,
      children: [
        Row(
          spacing: NumberConstant.statsGap,
          children: [
            _buildStatColumn(value: artist.itemsCount, label: StringConst.items),
            _buildStatSeparator(),
          ],
        ),
        Row(
          spacing: NumberConstant.statsGap,
          children: [
            _buildStatColumn(value: artist.volume, label: StringConst.volume, showEth: true),
            _buildStatSeparator(),
          ],
        ),
        _buildStatColumn(value: artist.floorPrice, label: StringConst.floorPrice, showEth: true),
      ],
    );
  }

  Widget _buildStatSeparator() {
    return SizedBox(
      height: NumberConstant.statsSeparatorHeight,
      child: CustomPaint(
        painter: const _VerticalDashedPainter(),
        child: const SizedBox(width: 1, height: NumberConstant.statsSeparatorHeight),
      ),
    );
  }

  Widget _buildStatColumn({required String value, required String label, bool showEth = false}) {
    return Column(
      children: [
        Row(
          mainAxisSize: .min,
          spacing: NumberConstant.microGap,
          children: [
            if (showEth) SvgPicture.asset(AssetRes.icEth),
            Text(value, style: AppTextStyles.labelMedium),
          ],
        ),
        Text(label, style: AppTextStyles.caption, textAlign: .center),
      ],
    );
  }

  Widget _buildWatchlistRow(BuildContext context) {
    return Row(
      spacing: NumberConstant.watchlistMoreGap,
      children: [
        Expanded(
          child: PrimaryButton(
            label: StringConst.watchlist,
            icon: AssetRes.icAdd,
            variant: .green,
            width: double.infinity,
            onTap: () => context.read<CollectionProvider>().toggleWatchlist(),
          ),
        ),
        SvgPicture.asset(AssetRes.icMore),
      ],
    );
  }

  Widget _buildTabs(BuildContext context, int tabIndex) {
    return Row(
      children: [
        Expanded(child: _buildTab(context, StringConst.itemsTab, 0, tabIndex == 0)),
        Expanded(child: _buildTab(context, StringConst.activity, 1, tabIndex == 1)),
      ],
    );
  }

  Widget _buildTab(BuildContext context, String label, int index, bool isActive) {
    return GestureDetector(
      onTap: () => context.read<CollectionProvider>().selectTab(index),
      behavior: .opaque,
      child: Column(
        spacing: NumberConstant.microGap,
        children: [
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(color: isActive ? AppColors.darkNormal : AppColors.darkLighter),
            textAlign: .center,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryGreen : AppColors.whiteColor,
              borderRadius: .circular(NumberConstant.tabUnderlineHeight),
            ),
            child: const SizedBox(width: double.infinity, height: NumberConstant.tabUnderlineHeight),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, NftModel nft) {
    return GestureDetector(
      onTap: () => context.push(NamedRoutes.detail.routeName, extra: nft),
      behavior: .opaque,
      child: ClipRRect(
        borderRadius: .circular(NumberConstant.gridItemRadius),
        child: Stack(
          fit: .expand,
          children: [
            Image.asset(nft.image, fit: .cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [
                    Color(0x00394C05),
                    AppColors.darkNormal,
                  ],
                ),
              ),
            ),
            Positioned(
              left: NumberConstant.gridItemOverlayPadding,
              right: NumberConstant.gridItemOverlayPadding,
              bottom: NumberConstant.gridItemOverlayPadding,
              child: Column(
                spacing: 0,
                crossAxisAlignment: .start,
                children: [
                  Text(nft.id, style: AppTextStyles.gridItemId),
                  Text(nft.name, style: AppTextStyles.gridItemName, maxLines: 1, overflow: .ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerticalDashedPainter extends CustomPainter {
  const _VerticalDashedPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.greyNormal
      ..strokeWidth = 1
      ..style = .stroke;
    const dashHeight = 3.0;
    const dashSpace = 3.0;
    var startY = 0.0;
    final x = size.width / 2;
    while (startY < size.height) {
      canvas.drawLine(Offset(x, startY), Offset(x, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
