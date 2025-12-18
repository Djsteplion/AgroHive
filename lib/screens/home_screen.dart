import '../screens/products_screen.dart';
import 'package:flutter/material.dart';
import '../providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../widgets/product_list.dart';
import '../providers/social_provider.dart';
import '../widgets/user_avatar_widget.dart';
//import '../screens/socials/social_feed_screen.dart';
import '../screens/profile_page_screen.dart';
import '../screens/cart_page.dart';
import '../services/weather_service.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onViewAllProducts;
  final VoidCallback? onViewSocials; // Callback for social feed navigation

  const HomeScreen({super.key, this.onViewAllProducts, this.onViewSocials});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> _products;
  final Map<String, bool> _isContentExpandedMap = {};
  final int _contentCharLimit = 150;
  static const Color _agroGreenColor = Color.fromARGB(255, 28, 98, 6);

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

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good morning";
    if (hour < 18) return "Good afternoon";
    return "Good evening";
  }

  void _setDate() {
    final now = DateTime.now();
    _date = DateFormat("E dd MMM yyyy").format(now);
  }

  Future<void> _fetchWeatherData() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();
      if (!serviceEnabled || permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) return;

      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final weather = await WeatherService.fetchWeather(pos.latitude, pos.longitude);

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
      case "rain": return "Rainy day – protect your crops!";
      case "clouds": return "Cloudy skies – good for planting.";
      case "clear": return "Sunny day – water your crops early.";
      case "thunderstorm": return "Thunderstorm alert – secure your farm!";
      default: return "Today is a good day to apply insecticide";
    }
  }

  void _addToCart(Product product) {
    Provider.of<ProductProvider>(context, listen: false).addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.name} added to cart')));
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
    setState(() { _isTapped = true; });
    if (widget.onViewAllProducts != null) {
      widget.onViewAllProducts!();
    } else {
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsScreen()));
      });
    }
  }

  String _formatTimeAgo(DateTime timestamp) {
    final Duration diff = DateTime.now().difference(timestamp);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePageScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined, color: Colors.grey),
              title: const Text('My Cart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border, color: Colors.grey),
              title: const Text('Favorite'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.delivery_dining_outlined, color: Colors.grey),
              title: const Text('Orders'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.notifications_on_outlined, color: Colors.grey),
              title: const Text('Notifications'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1, color: Colors.grey)),
                  child: const Icon(Icons.question_mark_rounded, color: Colors.grey)),
              title: const Text("FAQ's"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 25),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      currentUser != null
                          ? UserAvatarWidget(avatarUrl: currentUser.avatarUrl, radius: 22.0)
                          : const CircleAvatar(radius: 22.0, backgroundImage: AssetImage('assets/Frame 1194.png')),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentUser != null ? 'Hi ${currentUser.username},' : 'Hi Guest',
                              style: const TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w600, color: Colors.black),
                            ),
                            Text(
                              _getGreeting(),
                              style: const TextStyle(fontSize: 12, height: 1.5, fontWeight: FontWeight.w400, color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: Container(
                      width: 42, height: 42, padding: const EdgeInsets.all(12.5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100), boxShadow: const [BoxShadow(color: Color.fromARGB(178, 255, 255, 255), spreadRadius: 5, blurRadius: 15, offset: Offset(0, 1))]),
                      child: Container(width: 14, height: 8, decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/menu-Bold.png'), fit: BoxFit.cover))),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 6),
              child: Align(alignment: Alignment.topLeft, child: Text('Weather Update', style: TextStyle(fontSize: 14, height: 2.0, color: Color.fromARGB(178, 0, 0, 0), fontWeight: FontWeight.w500))),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 5, 15),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$_location, $_date', style: const TextStyle(fontSize: 12, height: 2.0, color: Color.fromARGB(77, 0, 0, 0), fontWeight: FontWeight.w500)),
                            const SizedBox(height: 5),
                            Text('${_temperature.toStringAsFixed(0)}°C', style: const TextStyle(fontSize: 20, color: _agroGreenColor, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 5),
                            Text('Humidity $_humidity%', style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Column(
                          children: [
                            Container(height: 39, width: 59, decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/weatherSunny.png'), fit: BoxFit.cover))),
                            Text(_condition, style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(margin: const EdgeInsets.fromLTRB(5, 10, 5, 15), height: 5, decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3))))),
                  const SizedBox(height: 5),
                  Align(alignment: Alignment.topLeft, child: Text(_advice, style: const TextStyle(fontSize: 12, height: 2.0, color: Color.fromARGB(77, 0, 0, 0), fontWeight: FontWeight.w400))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Farm products', style: TextStyle(fontSize: 14, height: 1.71, color: Colors.black, fontWeight: FontWeight.w500)),
                  GestureDetector(
                    onTap: _handleTapped,
                    child: Column(
                      children: [
                        const Text("view all", style: TextStyle(fontSize: 12, height: 2.0, color: _agroGreenColor)),
                        AnimatedContainer(duration: const Duration(milliseconds: 300), height: 1, width: _isTapped ? 65 : 0, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ProductList(products: _products, onAddToCart: _addToCart, onFavoriteToggle: _toggleFavorite),
            
            // Link "See all posts" to navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:5.0, vertical:15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recent Post', style: TextStyle(color: Colors.black, fontSize: 14, height: 1.71, fontWeight: FontWeight.w400)),
                  GestureDetector(
                    onTap: widget.onViewSocials, // Redirect when "See all posts" is clicked
                    child: const Text('See all posts', style: TextStyle(color: _agroGreenColor, fontSize: 12, height: 2.0, fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: socialProvider.initialPosts.length,
                itemBuilder: (context, index) {
                  final post = socialProvider.initialPosts[index];
                  final bool isFollowing = currentUser?.followedUserIds.contains(post.userId) ?? false;
                  final bool isContentExpanded = _isContentExpandedMap[post.id] ?? false;
                  final bool isLongContent = post.content.length > _contentCharLimit;
                  final String displayedContent = isLongContent && !isContentExpanded ? '${post.content.substring(0, _contentCharLimit)}...' : post.content;
                
                  // XYZ 
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: GestureDetector(
                      onTap: widget.onViewSocials, // Redirect when Card is clicked
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(backgroundImage: AssetImage(post.userAvatar)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Transform.translate(offset: const Offset(0, 2.5), child: Text(post.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                      const SizedBox(width: 25),
                                      Transform.translate(
                                        offset: const Offset(0, 5),
                                        child: Row(
                                          children: [
                                            Text(_formatTimeAgo(post.timestamp), style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[600], fontSize: 13)),
                                            const SizedBox(width: 2.5),
                                            Transform.translate(offset: const Offset(0, -4.5), child: const Text('...', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16))),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (currentUser != null && currentUser.id != post.userId)
                                  GestureDetector(
                                    onTap: () => socialProvider.toggleFollow(post.userId),
                                    child: Text(isFollowing ? 'Following' : 'Follow', style: const TextStyle(color: _agroGreenColor, fontWeight: FontWeight.bold)),
                                  ),
                              ],
                            ),
                          ),
                          if (post.imageUrl.isNotEmpty) Image.asset(post.imageUrl, fit: BoxFit.cover, width: double.infinity),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(displayedContent, style: const TextStyle(fontSize: 16)),
                                if (isLongContent)
                                  GestureDetector(
                                    onTap: () => setState(() => _isContentExpandedMap[post.id] = !isContentExpanded),
                                    child: Text(isContentExpanded ? 'Show Less' : 'Show More', style: const TextStyle(color: _agroGreenColor, fontWeight: FontWeight.bold)),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}