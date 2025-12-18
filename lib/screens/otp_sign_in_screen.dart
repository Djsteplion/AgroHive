import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpSignInScreen extends StatefulWidget {
  const OtpSignInScreen({super.key});

  @override
  State<OtpSignInScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpSignInScreen> {
  bool isOtpCorrect = true;
  final String correctOtp = "123456"; // replace with backend logic


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {Navigator.pop(context);},
                child: Row(
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 8),
                    Text("Back to login"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Text("Enter the code", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("We’ve sent a 6-digit code to your email. Please enter it below to verify your identity.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 30),
            OtpTextField(
              numberOfFields: 6,
              borderColor: isOtpCorrect ? Colors.green : Colors.red,
              focusedBorderColor: Colors.black,
              showFieldAsBox: true,
              borderWidth: 2.0,
              onSubmit: (String enteredOtp) {
                setState(() {
                  isOtpCorrect = enteredOtp == correctOtp;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text.rich(
              TextSpan(
                text: "Didn't receive the code? ",
                children: [
                  TextSpan(
                    text: "Resend",
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                // Your OTP logic
              },
              child: Text("Send OTP", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}