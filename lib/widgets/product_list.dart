import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_card.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onAddToCart;
  final Function(Product) onFavoriteToggle;

  const ProductList({
    required this.products,
    required this.onAddToCart,
    required this.onFavoriteToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
return GridView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  padding: const EdgeInsets.all(0),
  itemCount: 2,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 16,
    crossAxisSpacing: 16,
    // childAspectRatio: 0.72, // tweak this to make sure card fits nicely
  ),
  itemBuilder: (context, index) {
    final product = products[index];
    return ProductCard(
      product: product,
      onAddToCart: () => onAddToCart(product),
      onFavoriteToggle: () => onFavoriteToggle(product),
    );
  },
);


  }
}
