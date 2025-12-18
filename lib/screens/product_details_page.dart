import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Ensure you have provider setup
import '../models/product.dart';
import '../providers/product_provider.dart';
import 'cart_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
    // 👇 Default value is "Medium"
  String selectedSize = "Medium";

  // 👇 List of options
  final List<String> sizes = ["Small", "Medium", "Large"];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Image
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Hero(
                  tag: widget.product.id,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black, weight: 600),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          // Details
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  Text("\$${widget.product.price}",
                      style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),

                  Text(widget.product.description,
                      style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w400 )),
                  SizedBox(height: 30),
                  Text('Select size',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                 SizedBox(height: 5),

                /////////////////////////////////////// DROPDOWN MENU SELECTION

DropdownButtonFormField<String>(
            value: selectedSize,
            decoration: InputDecoration(
              focusColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.grey),
  ),// default border
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
    )
  ), 
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
            items: sizes.map((String size) {
              return DropdownMenuItem<String>(
                value: size,
                child: Text(size),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedSize = newValue!;
              });
            },
          ),

                //////////////////////////////////////
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap:() {
                            // Add to Cart
                            Provider.of<ProductProvider>(context, listen: false)
                                .addToCart(widget.product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Added to Cart!')),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 18,horizontal: 17),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 28, 98, 6),
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                'Add to cart',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 28, 98, 6),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap:() {
                            // Navigate to Cart page after adding product
                            Provider.of<ProductProvider>(context, listen: false)
                                .addToCart(widget.product);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CartPage()), // Directly go to Cart Page
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 17),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 28, 98, 6),
                              border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 28, 98, 6),
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
