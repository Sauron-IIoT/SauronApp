import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sauron/components/background/login.dart';
import 'package:sauron/components/color_loader.dart';
import 'package:sauron/screens/home/args.dart';
import 'package:sauron/services/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sauron/models/user.dart' as Models;

class StartupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartupScreenState();
}

class StartupScreenState extends State<StartupScreen> {
  @override
  Widget build(BuildContext context) => Stack(
      alignment: Alignment.center,
      children: <Widget>[LoginBackground(), ColorLoader()]);

  void initState() {
    super.initState();

    loadUser();
  }

  Future<void> loadUser() async {
    print('Chamou loadUser');
    getUser(FirebaseAuth.instance.currentUser.uid).then((user) {
      print('Chamou home' + user.userId);
      Navigator.pushReplacementNamed(context, "/home",
          arguments: HomeArguments(user.displayName, user.accountId));
    });
  }
}
