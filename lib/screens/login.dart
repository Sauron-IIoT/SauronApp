import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(203,145,228,1),
                  Color.fromRGBO(174,97,209,1),
                  Color.fromRGBO(159,60,205,1),
                  Color.fromRGBO(153,28,209,1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.4, 0.75, 1]
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Logo
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Text(
                      'Not implemented',
                    )
                  ),
                  // Form
                  Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Text('Not implemented')
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
