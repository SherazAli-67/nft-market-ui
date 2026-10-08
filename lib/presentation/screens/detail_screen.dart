import 'package:flutter/material.dart';
import 'package:nft_market_app_ui/constants/string_const.dart';
import 'package:nft_market_app_ui/core/app_textstyles.dart';
import 'package:nft_market_app_ui/presentation/widgets/app_back_button.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConst.detail, style: AppTextStyles.appBarTitle),
        leading: const Padding(
          padding: .only(left: 8),
          child: AppBackButton(),
        ),
        leadingWidth: 56,
      ),
      body: Center(child: Text(StringConst.detail, style: AppTextStyles.sectionTitle)),
    );
  }
}
