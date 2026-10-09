import 'package:nft_market_app_ui/constants/string_const.dart';
import 'package:nft_market_app_ui/core/asset_res.dart';
import 'package:nft_market_app_ui/core/models/artist_model.dart';
import 'package:nft_market_app_ui/core/models/nft_model.dart';

class AppData {
  static const categories = [
    StringConst.trending,
    StringConst.byArtist,
    StringConst.eth,
    StringConst.btc,
  ];

  static const topCollection = NftModel(
    id: StringConst.nftId18417,
    name: StringConst.nftNameApesG,
    image: AssetRes.topCollectionImg,
    priceEth: StringConst.nftPrice223,
    endsIn: StringConst.nftEndsIn,
    sold: 125,
    description: StringConst.nftDescription,
  );

  static const featuredNft = NftModel(
    id: StringConst.nftId14415,
    name: StringConst.nftNameApesB,
    image: AssetRes.detailImg,
    priceEth: StringConst.nftPrice223,
    endsIn: StringConst.nftEndsIn,
    sold: 125,
    description: StringConst.nftDescription,
  );

  static const collectionItems = [
    NftModel(
      id: StringConst.nftId14415,
      name: StringConst.nftNameApesB,
      image: AssetRes.detailImg,
      priceEth: StringConst.nftPrice223,
      endsIn: StringConst.nftEndsIn,
      sold: 125,
      description: StringConst.nftDescription,
    ),
    NftModel(
      id: StringConst.nftId15315,
      name: StringConst.nftNameApesD,
      image: AssetRes.itemImg2,
      priceEth: StringConst.nftPrice223,
      endsIn: StringConst.nftEndsIn,
      sold: 98,
      description: StringConst.nftDescription,
    ),
    NftModel(
      id: StringConst.nftId18417,
      name: StringConst.nftNameApesG,
      image: AssetRes.itemsImg2,
      priceEth: StringConst.nftPrice223,
      endsIn: StringConst.nftEndsIn,
      sold: 210,
      description: StringConst.nftDescription,
    ),
    NftModel(
      id: StringConst.nftId12414,
      name: StringConst.nftNameApesP,
      image: AssetRes.onboardingImg,
      priceEth: StringConst.nftPrice223,
      endsIn: StringConst.nftEndsIn,
      sold: 64,
      description: StringConst.nftDescription,
    ),
  ];

  static const bestArtist = ArtistModel(
    name: StringConst.artistName,
    avatar: AssetRes.bestArtistImg,
    banner: AssetRes.bannerImg,
    followers: StringConst.artistFollowers,
    bio: StringConst.artistBio,
    itemsCount: StringConst.artistItemsCount,
    volume: StringConst.artistVolume,
    floorPrice: StringConst.artistFloorPrice,
    isVerified: true,
  );
}
