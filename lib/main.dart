import 'package:flutter/material.dart';
import 'package:sauron/screens/login.dart';

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
      ),
      home: LoginScreen(),
    );
  }
}