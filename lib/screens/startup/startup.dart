
import 'package:flutter/material.dart';
import 'package:sauron/components/background/login.dart';
import 'package:sauron/components/color_loader.dart';

class StartupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartupScreenState();
}

class StartupScreenState extends State<StartupScreen> {

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: <Widget> [
      LoginBackground(),
      ColorLoader()
    ]
  );

  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => {
          Future.delayed(const Duration(milliseconds: 1500), () {
            setState(() {
              Navigator.pushReplacementNamed(context, "/home");
            });
          })
        });
  }
}