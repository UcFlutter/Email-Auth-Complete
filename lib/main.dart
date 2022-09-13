import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final EmailAuth emailAuth = EmailAuth(sessionName: 'Sample Session');

  final emailController = TextEditingController();

  final otpController = TextEditingController();

  void sendOTP() async {
    var result = await emailAuth.sendOtp(recipientMail: emailController.text);
    if (result) {
      print('OTP Sent');
    } else {
      print('Email Not Valid');
    }
  }

  validateOTP() {
    var result = emailAuth.validateOtp(
      recipientMail: emailController.text,
      userOtp: otpController.text,
    );
    if (result) {
      print('Validation Success');
    } else {
      print('Invalid OTP!!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Email Authentication'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: const OutlineInputBorder(),
                  suffixIcon: TextButton(
                    onPressed: () => sendOTP(),
                    child: const Text('Send OTP'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: otpController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'OTP',
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Verify OTP'),
              onPressed: () => validateOTP(),
            ),
          ],
        ),
      ),
    );
  }
}
