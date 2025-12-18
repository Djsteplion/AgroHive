import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback onFavoriteToggle;

  const ProductCard({
    required this.product,
    required this.onAddToCart,
    required this.onFavoriteToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      margin: EdgeInsets.all(5),
      width: 144,
      height: 0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
          boxShadow: [
            BoxShadow(
            color: Color.fromARGB(18, 48, 57, 60),
            spreadRadius: 0,
            blurRadius: 6,
            offset: Offset(0, 1), // changes position of shadow
             )
          ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product.imageUrl,
                  height: 92,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(153, 255, 255, 255),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      product.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                  
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2.5,
              vertical: 0,
            ),
            child: Column(
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(product.name, 
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color.fromARGB(255, 54, 56, 66),
                  )),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 12),
                    Text(product.rating.toString(),
                    style: TextStyle(
                      color: Color.fromARGB(127 , 0, 0, 0),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                    ),
                      ],
                    ),
               ],
              ),
            const SizedBox(height: 6),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  width: 65,
                  height: 27,
                  child: ElevatedButton(
                  onPressed: onAddToCart,
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 28, 98, 6),
                  padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
            
                ),
                child: const Text('Add to cart',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
                  ],
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
