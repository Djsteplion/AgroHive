import 'package:flutter/material.dart';
import '../screens/payment_screen.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:geolocator/geolocator.dart';

class ConfirmDetailsScreen extends StatefulWidget {
    final String fname;
    final String pnumb;
    final String? city;
    final String adrs;

    final String subTotal;
    final String total;

const  ConfirmDetailsScreen({
    required this.fname,
    required this.pnumb,
    this.city,
    required this.adrs,

    required this.subTotal,
    required this.total,
    super.key
    });

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmDetailsScreenState createState() => _ConfirmDetailsScreenState();
}

class _ConfirmDetailsScreenState extends State<ConfirmDetailsScreen> {
///  String name = '', phone = '', city = '', address = '';
// 1  LatLng? location;

  @override
  void initState() {
    super.initState();
   // 3 loadUserInfo();
   // getLocation();
  }

/* 2
  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      phone = prefs.getString('phone') ?? '';
      city = prefs.getString('city') ?? '';
      address = prefs.getString('address') ?? '';
    });
  }
*/

/* 6
  Future<void> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position pos = await Geolocator.getCurrentPosition();
    setState(() => location = LatLng(pos.latitude, pos.longitude));
  }

  */

  void _backToDeliveryInfo () {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    //double subtotal = 4767, delivery = 2, total = subtotal + delivery;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(child: Transform.translate(
        offset: Offset(-20, 0),
        child: const Text('Confirm Details', style: TextStyle(fontWeight: FontWeight.w600)))),
        backgroundColor: Color.fromARGB(255, 245, 245, 245)
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 245, 245),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                    SizedBox(height: 10),
                    Text(widget.fname, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18))
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _backToDeliveryInfo();
                  },
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phone number', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                    SizedBox(height: 10),
                    Text( widget.pnumb, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18))
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _backToDeliveryInfo();
                  },
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('City', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                    SizedBox(height: 10),
                    Text(widget.city ?? '', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18))
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _backToDeliveryInfo();
                  },
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(0),
                      width: 330,
                      child: Text(widget.adrs, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18)))
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _backToDeliveryInfo();
                  },
                )
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 103,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/Map (1).png'
                  ),
                  fit: BoxFit.cover,
                )
              ),
            ),
            SizedBox(height: 20),
            Container(
      padding: EdgeInsets.all(10),
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cart Summary',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
            Text(
             'Subtotal',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          
          Text("\$${widget.subTotal}",
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
          Text("\$${widget.total}",
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
                              MaterialPageRoute(builder: (context) => PaymentInfoScreen(
                                total: widget.total
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
                 // padding: EdgeInsets.symmetric(vertical: 17, horizontal: 40),
                  minimumSize: const Size(double.infinity, 60),
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
    )
          
          ],
        ),
        ),
        /*5
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailRow('Name', name),
            detailRow('Phone', phone),
            detailRow('City', city),
            detailRow('Address', address),
            SizedBox(height: 16),
            location == null
                ? CircularProgressIndicator()
                : SizedBox(
                    height: 200,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(target: location!, zoom: 14),
                      markers: {Marker(markerId: MarkerId('me'), position: location!)},
                    ),
                  ),
            SizedBox(height: 16),
            summaryRow('Subtotal', subtotal),
            summaryRow('Delivery Fee', delivery),
            Divider(),
            summaryRow('Total', total, bold: true),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
              onPressed: () {},
              child: Text('Checkout'),
            )
          ],
        ),
        */
      ),
    );
  }


}
