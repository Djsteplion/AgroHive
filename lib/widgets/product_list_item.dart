import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_details_page.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback onFavoriteToggle;

  const ProductListItem({
    required this.product,
    required this.onAddToCart,
    required this.onFavoriteToggle,
    super.key, 
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetailsPage(product: product)),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          leading: Hero(
            tag: product.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
            ),
          ),
          title: Text(product.name),
          subtitle: Text("\$${product.price}"),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }
}
