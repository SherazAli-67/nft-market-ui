class ArtistModel {
  final String name;
  final String avatar;
  final String banner;
  final String followers;
  final String bio;
  final String itemsCount;
  final String volume;
  final String floorPrice;
  final bool isVerified;

  const ArtistModel({
    required this.name,
    required this.avatar,
    required this.banner,
    required this.followers,
    required this.bio,
    required this.itemsCount,
    required this.volume,
    required this.floorPrice,
    required this.isVerified,
  });
}
