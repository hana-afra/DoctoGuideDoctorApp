// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:dio/dio.dart';
import 'screens/loginSignUp/login.dart';
import 'screens/splach/splash.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final dio = Dio();
Future<void> main() async {
  await Supabase.initialize(
    url: 'https://gkgupdxpofpowtfwcufj.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdrZ3VwZHhwb2Zwb3d0ZndjdWZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTMxMzM2NDcsImV4cCI6MjAyODcwOTY0N30.YQ1gz3dYcCVoA874jZDQ8-YPh02ib1wl1AWxZwQyXtE',
  );
  final supabase = Supabase.instance.client;
  runApp(MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
    );
  }
}
