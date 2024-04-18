// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_this, no_logic_in_create_state, use_key_in_widget_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import '../../constants/endpoints.dart';
import 'login.dart';
import '../../theme/theme.dart';
import '../../widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final dio = Dio();
final supabase = Supabase.instance.client;
FirebaseAuth auth = FirebaseAuth.instance;
bool correct = true;
String? verifyId;

class SignupScreen4 extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String birthDate;
  final String gender;
  final String phone;
  final String speciality;
  final String price;
  final String diploma;
  final String proNum;

  SignupScreen4({
    required this.name,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.price,
    required this.proNum,
    required this.speciality,
    required this.diploma,
  });

  @override
  State<SignupScreen4> createState() => _SignupScreen4State();
}

class _SignupScreen4State extends State<SignupScreen4> {
  @override
  void initState() {
    // TODO: implement initState
    phoneAuth();

    print('init state');
    super.initState();
  }

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

  Future<String> signupUser() async {
    String email = widget.email;
    String password = widget.password;
    String name = widget.name;
    String phone = widget.phone;
    String birthDate = widget.birthDate;
    String gender = widget.gender;
    String price = widget.price;
    String proNum = widget.proNum;
    String speciality  = widget.speciality;
    String diploma = widget.diploma;



    print(email);
    print(name);
    print(phone);
    print(password);
    print(birthDate);
    print(gender);
    print(price);
    print(proNum);
    print(speciality);
    print(diploma);

    try {
      print('before api');
      final response = await dio.get(
        '$api_endpoint_user_sign?name=$name&email=${Uri.encodeComponent(email.trim())}&password=$password&gender=$gender&phone=$phone&birthdate=$birthDate&price=$price&pronum=$proNum&diploma=$diploma&speciality=$speciality',
      );
      print('after api');

      print("Response: ${response..toString()}");

      Map<String, dynamic> ret_data = jsonDecode(response.toString());

      if (ret_data['status'] == 200) {
        dynamic userData = ret_data['data'];

        if (userData is List) {
          // Assuming the first element in the list is the user data
          if (userData.isNotEmpty && userData[0] is Map<String, dynamic>) {
            userData = userData[0];
          }
        }

        if (userData is Map<String, dynamic>) {
          // Access the user data from the map
          print(userData);

          print("success");
          return 'success';
        } else {
          print("fail");
          return 'Error: Unexpected user data format';
        }
      } else {
        showToast(ret_data['message']);
        print("fail");
        String error_msg = ret_data['message'] ?? 'Unknown error';
        return 'Error: $error_msg';
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  void phoneAuth() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        verifyId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  sentCode() async {
    print('sentCode function');
    try {
      print('enter try');
      String smsCode = controllers[0].text +
          controllers[1].text +
          controllers[2].text +
          controllers[3].text +
          controllers[4].text +
          controllers[5].text;
      print("phone auth");
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verifyId!, smsCode: smsCode);
      print('after');

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential).then((value) {
        if (value.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        } else
          () {
            print('>>>>>>>>>>>>>>not send');
          };
      });
    } catch (ex) {
      setState(() {
        correct = false;
        print('catch');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void onPressedVerifyCode() async {
      String signupResult = await signupUser();

      if (signupResult == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        // Handle signup failure
        print('Signup failed: $signupResult');
        // Display an error message or perform other actions accordingly
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
                    'Enter Verification Code',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Enter code that we have sent to your number',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                for (int i = 0; i < controllers.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: buildCodeBox(controllers[i]),
                  ),
              ]),

              const SizedBox(height: 50),
              ButtonGreen(text: 'Verify', onPressed: onPressedVerifyCode),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didnt receive the code?',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      // Call the login function when the text is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

// Create a list of controllers for each code box (assuming you have multiple)
List<TextEditingController> controllers = [
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  // Add more controllers if you have additional code boxes
];

Widget buildCodeBox(TextEditingController controller) {
  return Container(
    width: 45,
    height: 45,
    decoration: BoxDecoration(
      color: AppColors.thirdColor,
      border: Border.all(width: 1, color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(8),
    ),
    alignment: Alignment.center,
    child: TextField(
      controller: controller, // Assign the controller to the TextField
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      decoration: InputDecoration(
        counterText: '',
        border: InputBorder.none,
      ),
    ),
  );
}
