import 'package:flutter/material.dart';

class ChartTab extends StatelessWidget {
  final String text;
  final bool isSelected;

  const ChartTab({Key? key, required this.isSelected, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: isSelected ? 16 : 14,
              color: isSelected ? Colors.black : Colors.white,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          Container(
            height: 6,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color:
                  isSelected ? Color.fromRGBO(153, 28, 209, 1) : Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
