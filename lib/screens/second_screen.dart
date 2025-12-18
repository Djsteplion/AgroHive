import 'package:flutter/material.dart';
import 'package:new_agrohive_app/screens/sign_up_screen.dart';
import '../screens/third_screen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Stack(
          children: [
            Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/Rectangle 95 (1).png'), //assets/Rectangle 95 (1).png
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Image.asset(
                      'assets/Frame 1000007167 (2).png'
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                        padding: EdgeInsets.only(top: 15,right:10, left:10, bottom:10),
                        child: Text(
                          "Welcome to AgroHive: The Future of Farming", // Welcome to AgroHive: The Future of Farming
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
                          "Transform farming with drone technology and real-time data for better decision-making",
                          //Transform farming with drone technology and real-time data for better decision-making
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                   ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                       shape: BoxShape.circle,
                        border: Border(
                          top: BorderSide(color: Color.fromARGB(255, 28, 98, 6), width: 2),
                          left: BorderSide(color: Color.fromARGB(255, 28, 98, 6), width: 2),
                        ),
                    ),
                    child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Color.fromARGB(255, 28, 98, 6),
                    child: IconButton(
                          onPressed: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ThirdScreen()),
                           );
                    },
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
                    ),
                ),

                ],
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(7),
                  height: 36,
                  width: 84,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      width: 0.6,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                        );
                    },
                      child: Text('Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
    
    );
  }
}


