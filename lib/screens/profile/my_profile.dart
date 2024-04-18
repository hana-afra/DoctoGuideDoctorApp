// ProfilePage.dart
// ignore_for_file: prefer_const_constructors

import 'history.dart';
import 'myInformation.dart';
//import 'package:doctor_app_docto_guide/widgets/buttom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import 'package:doctor_app_docto_guide/widgets/Button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;


class MyProfile extends StatefulWidget {
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  String? name = '';
  late String _userId;
  String? imagePath =
      "https://jzredydxgjflzlgkamhn.supabase.co/storage/v1/object/sign/item/item/2024-01-26T21:30:55.587640.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJpdGVtL2l0ZW0vMjAyNC0wMS0yNlQyMTozMDo1NS41ODc2NDAuanBnIiwiaWF0IjoxNzA2MzAxMDU5LCJleHAiOjIwMjE2NjEwNTl9.EQ8qCe_8uC6EGsNxzptM88Cy8xCKtzg6d0VIeO-aEj4"; // Variable to store the picked image path

  Future<void> _loadUserData() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      setState(() {});

      _userId = _prefs.getString('user_id') ?? '';

      //to get the image

      final data =
          await supabase.from('user').select().eq('id_user', _userId).single();

      name = data['name'] as String;

      imagePath = data['profile_picture'] as String?;

      setState(() {});
    } catch (ex, st) {
      print('$ex $st ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor, // Change to your desired primary color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 110.0),

            // User Profile Information
            CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(imagePath!),
            ),
            SizedBox(height: 10.0),
            Text(
              '$name',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Birthstone',
                color: Colors.white,
              ),
            ),
            SizedBox(height: 90.0),

            // Action Buttons Container
            Expanded(
              child: Container(
                width: double.infinity,
               
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.0),

                    // Profile Action Buttons
                    buildProfileButton(
                      'My Information',
                      Icons.info,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyInformationPage()),
                        );
                      },
                    ),
                    buildProfileButton(
                      'History',
                      Icons.file_copy_rounded,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => History()),
                        );
                      },
                    ),
                    buildProfileButton(
                      'Password and Security',
                      Icons.security,
                      () {
                        // Add navigation logic for Password and Security page
                      },
                    ),
                    buildProfileButton(
                      'Language',
                      Icons.language,
                      () {
                        // Add navigation logic for Language page
                      },
                    ),
                    buildProfileButton(
                      'Log Out',
                      Icons.exit_to_app,
                      () {
                        // Add navigation logic for Log Out and show dialog
                        showLogoutDialog(context);
                      },
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileButton(String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Column(
        
        children: [
          
          ListTile(
            leading: Icon(
              icon,
              color: AppColors.primaryColor, // Set the color of the icon to black
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black, // Set the color of the text to black
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey, // Set the color of the arrow icon to black
                ),
    
              ],
            ),
            onTap: onTap,
          ),
          SizedBox(height: 7,),
          Divider(
                          color: AppColors.thirdColor,
                          height: 1,
                        ),
    
          
        ],
      ),
    );
  }
}

// Function to show the logout confirmation dialog
void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Log Out?',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to\n log out?',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 80,
                height: 50.0,
                margin:
                    EdgeInsets.only(bottom: 15.0), // Adjust margin as needed
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Color(0xFFB38586)),
                  color: Color(0xFFF2E9E8),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 50.0,
                margin:
                    EdgeInsets.only(bottom: 20.0), // Adjust margin as needed
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Color(0xFFAB8787)),
                  color: Color(0xFFCBABA4),
                ),
                child: TextButton(
                  onPressed: () {
                    // Clear user data and navigate to login screen
                    clearUserData();
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text(
                    'Log out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void clearUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("user_id");
  prefs.remove("user_name");
  prefs.remove("user_email");
  prefs.remove("user_phone");
  prefs.remove("user_password");
}
