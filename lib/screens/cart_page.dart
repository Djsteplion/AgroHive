import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';
import 'deliveryinfo_screen.dart';
import'../screens/main_screen.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<ProductProvider>(context).cartItems;
     //the '.cartItems' here
     // is the getter for all the cart items, that was defined in 'product_provider.dart'
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Transform.translate(
            offset: Offset(-20,0),
            child: Text('My Cart',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MainScreen()),
            );
          },
        ),
        /*
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ProductProvider>(context, listen: false).clearCart();
            },
          ),
        ],
        */
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('Your cart is empty.'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, index) {
                final cartItem = cartItems[index];
                return CartItemWidget(cartItem: cartItem);
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _showCheckoutModal(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 28, 98, 6),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          child: Text('Proceed to Checkout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
               fontWeight: FontWeight.w600,
              ),
          ),
        ),
      ),
    );
  }

  // Function to show the checkout modal
  void _showCheckoutModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return CheckoutModal();
      },
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final Product cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  cartItem.imageUrl,
                  height: 90,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(cartItem.name, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17)),
                  SizedBox(height: 30),
                  Text('\$${cartItem.price.toStringAsFixed(2)}',
                  style:TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      productProvider.removeFromCart(cartItem);
                    },
                    child: Transform.translate(
                      offset: Offset(0, -8),
                      child: Image.asset(
                        'assets/Trash-2.png'
                      ),
                    ),
                  ),
                  /*
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      productProvider.removeFromCart(cartItem);
                    },
                  ),
                  */
                  SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width:1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            productProvider.decreaseQuantity(cartItem);
                          },
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              vertical: BorderSide(
                                width: 1,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            )
                          ),
                          child:Text(cartItem.quantity.toString()),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            productProvider.increaseQuantity(cartItem);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckoutModal extends StatelessWidget {
  const CheckoutModal({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<ProductProvider>(context).cartItems;
    final totalAmount = cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    final total = 2 + totalAmount;

    return Container(
      padding: EdgeInsets.all(30),
      height: 400,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cart Summary',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
            Text(
             'Subtotal',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Text('\$${totalAmount.toStringAsFixed(2)}',
           style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600
            ),
          ),
            ],
          ),
          SizedBox(height: 16),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
            Text(
             'Delivery fees',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w300),
          ),
          Text('\$2.0',
           style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600
            ),
          ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
            Text(
             'Total:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Text('\$$total',
           style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700
            ),
          ),
            ],
          ),
          
          Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle checkout functionality (e.g., payment process)
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DeliveryInfoScreen(
                                subTotal: totalAmount.toStringAsFixed(2),
                                total: total.toString()
                              )),
                            );
                /*           
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Checkout Successful'),
                    content: Text('Your order has been placed successfully.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          //Navigator.pop(context); // Go back to the cart page
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
                 */
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 28, 98, 6),
                  padding: EdgeInsets.symmetric(vertical: 17, horizontal: 40),
               ),
              child: Text('Checkout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                 fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
