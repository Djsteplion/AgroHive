import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/social_provider.dart';
import '../models/product.dart';
import '../widgets/product_grid_item.dart';
import '../widgets/product_list_item.dart';
import '../widgets/user_avatar_widget.dart';
import '../screens/profile_page_screen.dart';
import '../screens/cart_page.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}


class _ProductsScreenState extends State<ProductsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _searchQuery = '';
  String _selectedFilter = 'All Products';
  bool _isGridView = true;

  void onAddToCart(Product product) {
    Provider.of<ProductProvider>(context, listen: false).addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} added to cart')),
    );
  }

  void onFavoriteToggle(Product product) {
    Provider.of<ProductProvider>(context, listen: false).toggleFavorite(product);
  }

  @override
  Widget build(BuildContext context) {
    final socialProvider = Provider.of<SocialProvider>(context);
    final currentUser = socialProvider.currentUser;

    final productProvider = Provider.of<ProductProvider>(context);
    List<Product> displayedProducts = productProvider.products.where((product) {
      //the '.products' here in  ''prodctProvider.products.where((product)'' above,
     // is the getter for all products, that was defined in 'product_provider.dart'
      final matchesSearch = product.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == 'All Products' ||
          (_selectedFilter == 'New Products' && product.isNew) ||
          (_selectedFilter == 'UK Used' && product.isUKProduct);
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.fromLTRB(24, 70, 24, 60),
          children:<Widget>[
            ListTile(
              leading: const Icon(Icons.person_outlined,color: Colors.grey,),
              title:  Text('Profile'),
              onTap: () {
                 Navigator.pop(context);// Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePageScreen()));
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined,color: Colors.grey,),
              title:  Text('My Cart'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border,color: Colors.grey,),
              title:  Text('Favorite'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delivery_dining_outlined,color: Colors.grey,),
              title:  Text('Orders'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_on_outlined,color: Colors.grey,),
              title:  Text('Notifications'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.pushNamed(context, '/home');
              },
            ),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width:1,
                      color: Colors.grey
                    )
                  ),
                  child: Icon(Icons.question_mark_rounded,color: Colors.grey,)),
                title:  Text("FAQ's"),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Navigator.pushNamed(context, '/home');
                },
              ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
              Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 25), // 25-left, 25-right on emulator
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                   child: Row( // First row containing avatar and menu button +++++++++++++++++++++++++++++++++
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      currentUser != null
                          ? UserAvatarWidget(
                              avatarUrl: currentUser.avatarUrl,
                              radius: 22.0,
                            )
                          : const CircleAvatar(
                              radius: 22.0,
                              backgroundImage: AssetImage('assets/Frame 1194.png'),
                            ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            currentUser != null ?
                            Text(
                              'Hi ${currentUser.username},',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ) : const Text(
                              'Hi Guest',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const Text(
                              'Good afternoon',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 0, 0, 0),
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
                      padding: EdgeInsets.all(12.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 248, 244, 244),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: Offset(0, 1), // changes position of shadow
                          )
                        ],
                      ),
                      child: Container(
                        width: 14,
                        height: 8,
                        decoration: BoxDecoration(
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
                // Search bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 250, //290 on emulator
                      
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 250, 250, 250),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: const Icon(
                              Icons.search, color: Colors.grey)
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Search for products or devices..',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                fillColor: Color.fromARGB(255, 250, 250, 250),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            
                    GestureDetector(
                      onTap: () {
                        _showSortOptions();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.fromLTRB(5, 4, 0, 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 242, 242, 242),
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/Frame 1000002236.png'
                            ),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                    ),
                  ],
                ),
            
                // Filter bar
                _buildFilterBar(),
            
                // Product list or grid
                Expanded(
                  child: displayedProducts.isEmpty
                      ? const Center(child: Text('No products found.'))
                      : _isGridView
                          ? GridView.builder(
                              padding: const EdgeInsets.all(1),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                              ),
                              itemCount: displayedProducts.length,
                              itemBuilder: (ctx, index) => ProductGridItem(
                                product: displayedProducts[index],
                                onAddToCart: () => onAddToCart(displayedProducts[index]),
                                onFavoriteToggle: () => onFavoriteToggle(displayedProducts[index]),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: displayedProducts.length,
                              itemBuilder: (ctx, index) => ProductListItem(
                                product: displayedProducts[index],
                                onAddToCart: () => onAddToCart(displayedProducts[index]),
                                onFavoriteToggle: () => onFavoriteToggle(displayedProducts[index]),
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      child: Row(
        children: [
          _buildFilterButton('All Products'),
          const SizedBox(width: 8),
          _buildFilterButton('New Products'),
          const SizedBox(width: 8),
          _buildFilterButton('UK Used'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    final isSelected = _selectedFilter == label;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        backgroundColor: isSelected ? Color.fromARGB(255, 28, 98, 6) : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Text(label,
        style: TextStyle(
        fontSize: 12,
       ),
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(_isGridView ? Icons.list : Icons.grid_view),
              title: Text(_isGridView ? 'Switch to List View' : 'Switch to Grid View'),
              onTap: () {
                setState(() {
                  _isGridView = !_isGridView;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_upward),
              title: const Text('Price: Low to High'),
              onTap: () {
                Provider.of<ProductProvider>(context, listen: false).sortByPriceAscending();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_downward),
              title: const Text('Price: High to Low'),
              onTap: () {
                Provider.of<ProductProvider>(context, listen: false).sortByPriceDescending();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Rating: High to Low'),
              onTap: () {
                Provider.of<ProductProvider>(context, listen: false).sortByRatingDescending();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_border),
              title: const Text('Rating: Low to High'),
              onTap: () {
                Provider.of<ProductProvider>(context, listen: false).sortByRatingAscending();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Clear Sort'),
              onTap: () {
                Provider.of<ProductProvider>(context, listen: false).resetSorting();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
