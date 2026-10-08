class NftModel {
  final String id;
  final String name;
  final String image;
  final String priceEth;
  final String endsIn;
  final int sold;
  final String description;

  const NftModel({
    required this.id,
    required this.name,
    required this.image,
    required this.priceEth,
    required this.endsIn,
    required this.sold,
    required this.description,
  });
}
