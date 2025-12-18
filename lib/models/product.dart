class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double rating;
  final String description;
  bool isFavorite;
  final bool isNew;
  final bool isUKProduct;
  int quantity; // mutable so it can change in cart

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.description,
    this.isFavorite = false,
    this.isNew = false,
    this.isUKProduct = false,
    this.quantity = 1,
  });
}
