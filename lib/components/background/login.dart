import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromRGBO(203, 145, 228, 1),
              Color.fromRGBO(174, 97, 209, 1),
              Color.fromRGBO(159, 60, 205, 1),
              Color.fromRGBO(153, 28, 209, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.75, 1]),
      ),
    );
  }
}
