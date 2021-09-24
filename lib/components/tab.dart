import 'package:flutter/material.dart';

class ChartTab extends StatelessWidget {
  final String text;
  final int selectedPage;
  final int pageNumber;
  final Function onTap;

  const ChartTab(
      {Key? key,
      required this.selectedPage,
      required this.pageNumber,
      required this.text,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 100,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: pageNumber == selectedPage ? Colors.black : Colors.white,
                fontWeight: pageNumber == selectedPage
                    ? FontWeight.w600
                    : FontWeight.w500,
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastLinearToSlowEaseIn,
              height: 6,
              width: pageNumber == selectedPage? 30: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: pageNumber == selectedPage
                    ? Color.fromRGBO(153, 28, 209, 1)
                    : Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
