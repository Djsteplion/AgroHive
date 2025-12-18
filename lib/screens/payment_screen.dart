import 'package:flutter/material.dart';
import './main_screen.dart';



class PaymentInfoScreen extends StatefulWidget {
    final String total;

  const PaymentInfoScreen({
    required this.total,
    super.key
    });

  @override
  State<PaymentInfoScreen> createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {

  bool isChecked = false;
  void goToConfirm(BuildContext context) {
    /*
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ConfirmDetailsScreen()),
    );
    */
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
        child: const Text('Payment Info', style: TextStyle(fontWeight: FontWeight.w600)))),
        backgroundColor: Colors.white,
        ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Enter your payment information below to continue',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w300,
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
            Align(
              alignment: Alignment.topLeft,
              child: Text('Pay With:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18
                ))),
            Transform.translate(
              offset: Offset(-11.5, 0),
              child: Row(
                children: [
                  Radio(value: true, groupValue: true, activeColor:Color.fromARGB(255, 28, 98, 6), onChanged: (_) {}),
                  Text('Card'),
                  Radio(value: true, groupValue: false, onChanged: (_) {}),
                  Text('Bank'),
                  Radio(value: true, groupValue: false, onChanged: (_) {}),
                  Text('Transfer'),
                ],
              ),
            ),
            SizedBox(height: 15),
            Align(alignment:Alignment.topLeft, child: Text('Credit card number', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400))),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(
              labelText: 'Enter credit card number',
              filled: true,
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(51, 0, 0, 0),
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
              )),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(alignment:Alignment.topLeft, child: Text('Expiration date', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400))),
                      SizedBox(height: 10),
                      TextField(decoration: InputDecoration(
                        filled: true,
                          fillColor: Color.fromARGB(255, 245, 245, 245),
                          labelStyle: TextStyle(
                            color: Color.fromARGB(51, 0, 0, 0),
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
                        labelText: 'mm/yy',
                        )),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    children: [
                      Align(alignment:Alignment.topLeft, child: Text('CVV', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400))),
                      SizedBox(height: 10),
                      TextField(decoration: InputDecoration(
                        labelText: 'Enter your CVV',
                        filled: true,
                          fillColor: Color.fromARGB(255, 245, 245, 245),
                           labelStyle: TextStyle(
                            color: Color.fromARGB(51, 0, 0, 0),
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
                        )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Transform.translate(
              offset:Offset(-10, 0),
              child: Row(
                children:[
                Checkbox(value: isChecked, onChanged: (value) {
                setState(() {
                  isChecked = !isChecked;
                });
              }, 
              activeColor: Color.fromARGB(255, 28, 98, 6),
              checkColor:Colors.white ,
              side: BorderSide(color: Color.fromARGB(128, 0, 0, 0)),
              
              ), Text('Save card details')]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 70),
                backgroundColor: Color.fromARGB(255, 28, 98, 6),
                foregroundColor: Colors.white,
                ),
              onPressed: ()  {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen() ));
                  // then this
                  showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Container(
                        height: 440,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 124,
                              height: 124,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/succesfull circle (1).png'),
                                  fit: BoxFit.cover,
                                )
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Congratulations',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color:Color.fromARGB(255, 28, 98, 6)),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Your Payment has been completed',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color:Color.fromARGB(128, 0, 0, 0)),
                            ),
                            SizedBox(height: 1),
                            Text(
                              'please check delivery status at',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color:Color.fromARGB(128, 0, 0, 0)),
                            ),
                            SizedBox(height: 1),
                            Text(
                              'order tracking page',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color:Color.fromARGB(128, 0, 0, 0)),
                            ),
                            SizedBox(height: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 70),
                                backgroundColor: Color.fromARGB(255, 28, 98, 6),
                                foregroundColor: Colors.white,
                                ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Go back to shopping',
                                    style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 19),
                                  ),
                                  SizedBox(width: 2),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 23,
                                  )
                                ],
                              )
                            ) 
                          ],
                        ),
                      ),
                   );
                  }
                  /*
                  AlertDialog(
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
                  */
                );
              },
              child: Text('Pay  \$${widget.total}',
                  style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}