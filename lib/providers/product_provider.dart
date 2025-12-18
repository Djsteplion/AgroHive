import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  // List of all products
  final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'Rotavator',
      imageUrl: 'assets/Rotavator.png',
      price: 59.50,
      rating: 4.5,
      isFavorite: false,
      isNew: true,
      isUKProduct: false,
      description: 'A powerful rotavator for efficient soil preparation.',
    ),
    Product(
      id: 'p2',
      name: 'EcoWagon',
      imageUrl: 'assets/EcoWagon.png',
      price: 785,
      rating: 4.1,
      isFavorite: false,
      isNew: false,
      isUKProduct: true,
      description: 'An eco-friendly cart for farm transport.',
    ),
    Product(
      id: 'p3',
      name: 'Mini-Tractor',
      imageUrl: 'assets/miniTractor.png',
      price: 36.9,
      rating: 4.0,
      isFavorite: false,
      isNew: false,
      isUKProduct: true,
      description: 'Compact yet powerful tractor for small farms.',
    ),
    Product(
      id: 'p4',
      name: 'Lawn Mower',
      imageUrl: 'assets/mower.png',
      price: 245,
      rating: 3.0,
      isFavorite: false,
      isNew: false,
      isUKProduct: true,
      description: 'Lightweight mower for your perfect lawn.',
    ),
    Product(
      id: 'p5',
      name: 'Drone Sprayer',
      imageUrl: 'assets/sprayer.png',
      price: 899.00,
      rating: 4.2,
      isFavorite: false,
      isNew: false,
      isUKProduct: true,
      description: 'Smart drone for efficient pesticide spraying.',
    ),
    Product(
      id: 'p6',
      name: 'Auto Planter',
      imageUrl: 'assets/robot.png',
      price: 150,
      rating: 2.0,
      isFavorite: false,
      isNew: false,
      isUKProduct: true,
      description: 'Robot planter for automated crop sowing.',
    ),
  ];

  // Getter for all products
  List<Product> get products => [..._products];

  // List of cart items
  final List<Product> _cartItems = [];

  // Getter for cart items
  List<Product> get cartItems => _cartItems;

  // Add product to cart
  void addToCart(Product product) {
    final existingIndex = _cartItems.indexWhere((p) => p.id == product.id); // you can change the p to anything
    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(
        Product(
          id: product.id,
          name: product.name,
          imageUrl: product.imageUrl,
          price: product.price,
          rating: product.rating,
          description: product.description,
          isFavorite: product.isFavorite,
          isNew: product.isNew,
          isUKProduct: product.isUKProduct,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  // Remove product from cart
  void removeFromCart(Product product) {
    _cartItems.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(Product product) {
    final index = _cartItems.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  // Decrease quantity
  void decreaseQuantity(Product product) {
    final index = _cartItems.indexWhere((p) => p.id == product.id);
    if (index >= 0 && _cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
      notifyListeners();
    }
  }

  // Clear entire cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Toggle favorite
  void toggleFavorite(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _products[index].isFavorite = !_products[index].isFavorite;
      notifyListeners();
    }
  }

  // Sorting logic
  void sortByPriceAscending() {
    _products.sort((a, b) => a.price.compareTo(b.price));
    notifyListeners();
  }

  void sortByPriceDescending() {
    _products.sort((a, b) => b.price.compareTo(a.price));
    notifyListeners();
  }

  void sortByRatingAscending() {
    _products.sort((a, b) => a.rating.compareTo(b.rating));
    notifyListeners();
  }

  void sortByRatingDescending() {
    _products.sort((a, b) => b.rating.compareTo(a.rating));
    notifyListeners();
  }

  void resetSorting() {
    _products.sort((a, b) => a.id.compareTo(b.id));
    notifyListeners();
  }
}
