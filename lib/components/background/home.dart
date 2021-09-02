import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromRGBO(153, 28, 209, 1),
              Color.fromRGBO(203, 145, 228, 1),
              Color.fromRGBO(255, 255, 255, 1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.3, 1]),
      ),
    );
  }
}
