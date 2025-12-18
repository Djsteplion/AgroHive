// ignore_for_file: unused_element

import '../screens/cart_page.dart';
import '../screens/products_screen.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/profile_page_screen.dart';
import '../screens/socials/social_feed_screen.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(
        onViewAllProducts: () => _onItemTapped(1), 
        onViewSocials: () => _onItemTapped(3), // Swaps to Community Tab
      ),
      const ProductsScreen(),
      const CartPage(),
      const SocialFeedScreen(),
      const ProfilePageScreen(),
    ];

    final List<IconData> _icons = [
      Iconsax.home_2,
      Icons.shopping_bag_outlined,
      Icons.shopping_cart_outlined,
      Iconsax.people,
      Icons.person_outline
    ];

    final List<String> _texts = [
      'Home',
      'Market',
      'Cart',
      'Community',
      'Profile',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_icons.length, (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: isSelected 
                    ? const EdgeInsets.symmetric(vertical: 12, horizontal: 16) 
                    : const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color.fromARGB(255, 28, 98, 6) : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(
                      _icons[index],
                      color: isSelected ? Colors.white : Colors.black.withValues(alpha:0.5),
                      size: 18,
                    ),
                    if (isSelected)
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(
                          _texts[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNavBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(27, 20, 27, 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: const DecorationImage(
                    image: AssetImage('assets/Frame 1194.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi Boluwa,',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Good afternoon',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}