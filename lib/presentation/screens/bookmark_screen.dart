import 'package:flutter/material.dart';
import 'package:nft_market_app_ui/constants/string_const.dart';
import 'package:nft_market_app_ui/core/app_textstyles.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(StringConst.bookmarkPlaceholder, style: AppTextStyles.sectionTitle)),
    );
  }
}
