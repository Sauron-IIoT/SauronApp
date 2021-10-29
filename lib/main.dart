import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sauron/screens/home/home.dart';
import 'package:sauron/screens/startup/startup.dart';
import 'package:sauron/screens/login/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        "/startup": (_) => new StartupScreen(),
        "/login": (_) => new LoginScreen(),
      },
      home: LoginScreen(),
    );
  }
}
