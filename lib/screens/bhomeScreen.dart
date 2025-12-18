import '../screens/products_screen.dart';
import 'package:flutter/material.dart';
import '../providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../widgets/product_list.dart';
import '../providers/social_provider.dart';
import '../widgets/user_avatar_widget.dart';
import '../models/post_model.dart';
//import '../screens/socials/social_feed_screen.dart';
import '../screens/profile_page_screen.dart';
import '../screens/cart_page.dart';

// ✨ NEW imports
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import '../services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> _products;

  // Social content states
//  final Map<String, bool> _isContentExpandedMap = {};
//  final int _contentCharLimit = 150;
//  static const Color _agroGreenColor = Color.fromARGB(255, 28, 98, 6);

  // ✨ Weather states with defaults
  String _location = "Ajah Lagos";
  String _date = "";
  double _temperature = 35.0;
  int _humidity = 72;
  String _condition = "Cloudy";
  String _advice = "Today is a good day to apply insecticide";

  @override
  void initState() {
    super.initState();
    _setDate();
    _fetchWeatherData();
  }

  void _setDate() {
    final now = DateTime.now();
    _date = DateFormat("E dd MMM yyyy").format(now); // Mon 27 Nov 2023
  }

  Future<void> _fetchWeatherData() async {
    try {
      // Ask for location permission
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();

      if (!serviceEnabled || permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        print("Location denied. Using default Ajah Lagos.");
        return; // Keep defaults
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final weather =
          await WeatherService.fetchWeather(pos.latitude, pos.longitude);

      if (weather != null) {
        setState(() {
          _location = weather["name"] ?? "Ajah Lagos";
          _temperature = weather["main"]["temp"]?.toDouble() ?? 35;
          _humidity = weather["main"]["humidity"] ?? 72;
          _condition = weather["weather"][0]["main"] ?? "Cloudy";
          _advice = _generateAdvice(_condition);
        });
      }
    } catch (e) {
      print("Weather fetch failed: $e");
    }
  }

  String _generateAdvice(String condition) {
    switch (condition.toLowerCase()) {
      case "rain":
        return "Rainy day – protect your crops!";
      case "clouds":
        return "Cloudy skies – good for planting.";
      case "clear":
        return "Sunny day – water your crops early.";
      case "thunderstorm":
        return "Thunderstorm alert – secure your farm!";
      default:
        return "Today is a good day to apply insecticide";
    }
  }

  void _addToCart(Product product) {
    Provider.of<ProductProvider>(context, listen: false).addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} added to cart')),
    );
  }

  // ignore: unused_element
  void _toggleFavoritePost(PostModel post) {
    Provider.of<SocialProvider>(context, listen: false).toggleLike(post);
  }

  void _toggleFavorite(Product product) {
    Provider.of<ProductProvider>(context, listen: false).toggleFavorite(product);
    setState(() {
      final index = _products.indexWhere((p) => p.id == product.id);
      _products[index] = Product(
        id: product.id,
        name: product.name,
        imageUrl: product.imageUrl,
        price: product.price,
        rating: product.rating,
        isFavorite: !product.isFavorite,
        description: product.description,
      );
    });
  }

  bool _isTapped = false;

  void _handleTapped() {
    setState(() {
      _isTapped = true;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProductsScreen()),
      );
    });
  }

  // ignore: unused_element
  String _formatTimeAgo(DateTime timestamp) {
    final Duration diff = DateTime.now().difference(timestamp);
    if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final socialProvider = Provider.of<SocialProvider>(context);
    final currentUser = socialProvider.currentUser;
    _products = Provider.of<ProductProvider>(context).products;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(50, 70, 50, 60),
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.person_outlined, color: Colors.grey),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePageScreen()),
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.shopping_cart_outlined, color: Colors.grey),
              title: const Text('My Cart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            // --- HEADER ---
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 25),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      currentUser != null
                          ? UserAvatarWidget(
                              avatarUrl: currentUser.avatarUrl, radius: 22.0)
                          : const CircleAvatar(
                              radius: 22.0,
                              backgroundImage:
                                  AssetImage('assets/Frame 1194.png'),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            currentUser != null
                                ? Text(
                                    'Hi ${currentUser.username},',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : const Text(
                                    'Hi Guest',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            const Text(
                              'Good afternoon',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      padding: const EdgeInsets.all(12.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(178, 255, 255, 255),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                      child: Container(
                        width: 14,
                        height: 8,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/menu-Bold.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // --- WEATHER ---
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Align(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Weather Update',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(178, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 5, 15),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$_location, $_date',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(77, 0, 0, 0),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${_temperature.toStringAsFixed(0)}°C',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 28, 98, 6),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Humidity $_humidity%',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 39,
                              width: 59,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/weatherSunny.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              _condition,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                    height: 5,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Colors.grey.withOpacity(0.3)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _advice,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(77, 0, 0, 0),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- PRODUCTS ---
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Farm products',
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: _handleTapped,
                    child: Column(
                      children: [
                        const Text(
                          "view all",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 28, 98, 6),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 1,
                          width: _isTapped ? 65 : 0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ProductList(
              products: _products,
              onAddToCart: _addToCart,
              onFavoriteToggle: _toggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}
