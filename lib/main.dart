import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sauron/screens/home/home.dart';
import 'package:sauron/screens/startup/startup.dart';
import 'package:sauron/screens/login/login.dart';

void main() {
  runApp(SauronApp());
}

class SauronApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.montserrat().fontFamily
      ),
      routes: {
        "/home": (_) => new HomeScreen(),
        "/login": (_) => new LoginScreen(),
      },
      home: HomeScreen(),
    );
  }
}