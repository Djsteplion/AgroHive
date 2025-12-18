import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/confirmdetails_screen.dart';

class DeliveryInfoScreen extends StatefulWidget {
    final String subTotal;
    final String total;

  const DeliveryInfoScreen({
    required this.subTotal,
    required this.total,
    super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DeliveryInfoScreenState createState() => _DeliveryInfoScreenState();
}

class _DeliveryInfoScreenState extends State<DeliveryInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String? selectedCity; // state variable
  final TextEditingController _addressController = TextEditingController();
  
  String name = '';
  String phone = '';
  String city = '';
  String address = '';

  // Save data using SharedPreferences
  Future<void> saveUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('phone', phone);
    await prefs.setString('city', city);
    await prefs.setString('address', address);
  }

  // Handle form validation and navigation
  void goToPayment() async {
    if (_formKey.currentState!.validate()) {
      await saveUserInfo();

      if (!mounted) return; // Prevents using context if widget is disposed

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConfirmDetailsScreen(
          fname: _fullnameController.text,
          pnumb: _phoneNumberController.text,
          city: selectedCity ?? ' ',
          adrs: _addressController.text,
          subTotal: widget.subTotal,
          total: widget.total,
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: const Text('Delivery Info', style: TextStyle(fontWeight: FontWeight.w600)))),
        backgroundColor: Colors.white,
        ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Enter your payment information below \nto continue',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 3),
            Text(
              'to continue',
                style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(alignment:Alignment.topLeft, child: Text('Name', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400))),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _fullnameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      labelText: 'Enter your full name',
                       labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        floatingLabelStyle:  TextStyle(
                          color: Colors.black,
                          fontSize: 13.5,
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Color.fromARGB(26, 0, 0, 0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(26, 0, 0, 0),
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    onChanged: (val) => name = val,
                    validator: (val) => val!.isEmpty ? 'Name is required' : null,
                  ),
                  SizedBox(height: 20),
                  Align(alignment:Alignment.topLeft, child: Text('Phone Number', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400))),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      labelText: 'Enter your phone number',
                       labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Color.fromARGB(26, 0, 0, 0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(26, 0, 0, 0),
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    keyboardType: TextInputType.phone,
                    onChanged: (val) => phone = val,
                    validator: (val) => val!.isEmpty ? 'Phone number is required' : null,
                  ),
                  SizedBox(height: 20),
                  Align(alignment:Alignment.topLeft, child: Text('City', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400))),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      labelText: 'Choose your city',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Color.fromARGB(26, 0, 0, 0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(26, 0, 0, 0),
                            width: 1,
                          ),
                        ),
                      ),
                    value: selectedCity, // Use the state variable here
                    items: ['Ibadan', 'Lagos', 'Abuja']
                        .map((city) => DropdownMenuItem<String>(value: city, child: Text(city)))
                        .toList(),
                    onChanged: (String? val) {
                      setState(() {
                        selectedCity = val; // Correctly update the state variable inside setState
                      });
                    },
                    validator: (val) => val == null || val.isEmpty ? 'City is required' : null,
                  ),
                  SizedBox(height: 20),
                  Align(alignment:Alignment.topLeft, child: Text('Address', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400))),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      labelText: 'Enter delivery address',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Color.fromARGB(26, 0, 0, 0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(26, 0, 0, 0),
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    onChanged: (val) => address = val,
                    validator: (val) => val!.isEmpty ? 'Address is required' : null,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 70),
                      backgroundColor: Color.fromARGB(255, 28, 98, 6),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: goToPayment,
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
