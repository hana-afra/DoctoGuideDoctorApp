// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:convert';

import 'package:dio/dio.dart';
import '../../constants/endpoints.dart';
import 'login.dart';
import 'signupStep4.dart';
import '../../theme/theme.dart';
import '../../widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

final dio = Dio();
final supabase = Supabase.instance.client;
FirebaseAuth auth = FirebaseAuth.instance;
bool correct = true;
String? verifyId;

class SignupScreen3 extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String birthDate;
  final String gender;
  final String speciality;
  final String price;
  final String diploma;
  final String proNum;
  

  SignupScreen3({
    required this.name,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.gender,
    required this.price,
    required this.proNum,
    required this.speciality,
    required this.diploma,
    
  });

  @override
  State<SignupScreen3> createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen3> {
  final TextEditingController phoneController = TextEditingController();

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      textColor: const Color.fromARGB(255, 0, 0, 0),
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    void onPressedSendCode() {
      String phone = phoneController.text.trim();

      // Validate phone number format
      // if (phone.length == 10 &&
      //     (phone.startsWith('05') ||
      //         phone.startsWith('06') ||
      //         phone.startsWith('07'))) {
      if (phone.length > 5) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignupScreen4(
              email: widget.email,
              password: widget.password,
              name: widget.name,
              phone: phone,
              birthDate: widget.birthDate,
              gender: widget.gender,
              price: widget.price,
              proNum : widget.proNum,
              speciality : widget.speciality,
              diploma : widget.diploma,

            ),
          ),
        );
      } else {
        // Show error message for invalid phone number format
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Invalid Phone Number'),
            content: Text('Please enter a valid phone number.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 90.0), // Adjust left padding as needed
          child: Text(
            'Sign Up',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make text bold
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen (SplashScreen)
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Horizontal Line with "Or" Text
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors
                                .primaryColor, // Adjust color as needed
                            width: 2.0, // Adjust thickness as needed
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors
                                .primaryColor, // Adjust color as needed
                            width: 2.0, // Adjust thickness as needed
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors
                                .primaryColor, // Adjust color as needed
                            width: 2.0, // Adjust thickness as needed
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              //const SizedBox(height: 40),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter your Phone Number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Enter your phone number, we will send\nyou confirmation code',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              InputButton(
                hintText: 'Phone Number',
                controller: phoneController,
                //obscureText: true,
              ),

              const SizedBox(height: 40),
              ButtonGreen(text: 'Send Code', onPressed: onPressedSendCode),
              const SizedBox(height: 40),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
