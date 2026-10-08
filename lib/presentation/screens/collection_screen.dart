import 'package:flutter/material.dart';
import 'package:nft_market_app_ui/constants/string_const.dart';
import 'package:nft_market_app_ui/core/app_textstyles.dart';
import 'package:nft_market_app_ui/presentation/providers/collection_provider.dart';
import 'package:nft_market_app_ui/presentation/widgets/app_back_button.dart';
import 'package:provider/provider.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CollectionProvider(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text(StringConst.collection, style: AppTextStyles.appBarTitle),
          leading: const Padding(
            padding: .only(left: 8),
            child: AppBackButton(),
          ),
          leadingWidth: 56,
        ),
        body: Center(child: Text(StringConst.collection, style: AppTextStyles.sectionTitle)),
      ),
    );
  }
}
