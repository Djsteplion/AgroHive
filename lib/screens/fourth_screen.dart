import 'package:flutter/material.dart';
import '../screens/sign_up_screen.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              body: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/WhatsApp Image 2025-01-12 at 21.14.17_89aeda38 (1).png'), //assets/Rectangle 95 (1).png
                        fit: BoxFit.cover
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: Image.asset(
                          'assets/Group 1 (1).png'
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Image.asset(
                      'assets/Frame 1000007167.png'
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                        padding: EdgeInsets.only(top: 15,right:10, left:10, bottom:10),
                        child: Text(
                          "The Future of Farming is Here and It's Connected", 
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            height: 1.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                   ),
                   Container(
                        padding: EdgeInsets.only(top: 15,right:10, left:10, bottom:10),
                        child: const Text(
                          "Join a global network of tech-savvy farmers transforming agriculture with smart solutions",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                   ),
                   SizedBox(height: 25),
                   Container(
                    width: 200,
                    padding: EdgeInsets.fromLTRB(25,3,3,4),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 28, 98, 6),
                      borderRadius: BorderRadius.circular(32),
                    ),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                         CircleAvatar(
                              radius: 26,
                              backgroundColor:Colors.white.withOpacity(0.3),
                              child: IconButton(
                                onPressed: () {
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignupScreen()),
                                 );
                               },
                             icon: const Icon(Icons.arrow_forward, color: Colors.white),
                             ),
                                           ),
                       ],
                     ),
                   ),
                            
                ],
              ),
    
    );
  }
}