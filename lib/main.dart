import 'package:flutter/material.dart';
import 'package:jelajah_nusantara/artikel/artikel_screen.dart';
import 'package:jelajah_nusantara/artikel/detail_screnn.dart';
import 'package:jelajah_nusantara/screens/home/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF6F2E5)),
      home: Splash(),
    );
  }
}
