class Product {
  final String name;
  final String category;
  final String brand;
  final String price;
  final String? oldPrice;
  final List<String> images; // Changed to a list of images
  final double rating;
  final int reviews;
  final bool isPopular;
  final bool isNew;
  final DateTime? promotionDeadline;
  final bool isForOffice;
  final bool isForPowerUsers;
  final bool isForLargeBusiness;
  final bool isSecondHand;

  Product({
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    this.oldPrice,
    required this.images,
    this.rating = 0.0,
    this.reviews = 0,
    this.isPopular = false,
    this.isNew = false,
    this.promotionDeadline,
    this.isForOffice = false,
    this.isForPowerUsers = false,
    this.isForLargeBusiness = false,
    this.isSecondHand = false,
  });
}
