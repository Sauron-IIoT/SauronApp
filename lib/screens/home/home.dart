import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sauron/components/background/home.dart';
import 'package:sauron/components/bottom_menu/bottom_menu.dart';
import 'package:sauron/components/tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget> [
        HomeBackground(),
        Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 0
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
                  Container(
                    child: Text(
                      'Olá, Murilo',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        ChartTab(text: 'Semanal', isSelected: false),
                        ChartTab(text: 'Mensal', isSelected: true),
                        ChartTab(text: 'Anual', isSelected: false),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.infinity,
                    child: BezierChart(
                      bezierChartScale: BezierChartScale.CUSTOM,
                      xAxisCustomValues: const [0, 3, 10, 15, 20, 25, 30, 35],
                      series: const [
                        BezierLine(
                          lineColor: Color.fromRGBO(153, 28, 209, 1),
                          label: "Peça 1",
                          data: const [
                            DataPoint<double>(value: 10, xAxis: 0),
                            DataPoint<double>(value: 130, xAxis: 5),
                            DataPoint<double>(value: 50, xAxis: 10),
                            DataPoint<double>(value: 150, xAxis: 15),
                            DataPoint<double>(value: 75, xAxis: 20),
                            DataPoint<double>(value: 0, xAxis: 25),
                            DataPoint<double>(value: 5, xAxis: 30),
                            DataPoint<double>(value: 45, xAxis: 35),
                          ],
                        ),
                        BezierLine(
                          lineColor: Colors.blue,
                          lineStrokeWidth: 2.0,
                          label: "Peça 2",
                          data: const [
                            DataPoint<double>(value: 5, xAxis: 0),
                            DataPoint<double>(value: 50, xAxis: 5),
                            DataPoint<double>(value: 30, xAxis: 10),
                            DataPoint<double>(value: 30, xAxis: 15),
                            DataPoint<double>(value: 50, xAxis: 20),
                            DataPoint<double>(value: 40, xAxis: 25),
                            DataPoint<double>(value: 10, xAxis: 30),
                            DataPoint<double>(value: 30, xAxis: 35),
                          ],
                        ),
                        BezierLine(
                          lineColor: Colors.black,
                          lineStrokeWidth: 2.0,
                          label: "Peça 3",
                          data: const [
                            DataPoint<double>(value: 5, xAxis: 0),
                            DataPoint<double>(value: 10, xAxis: 5),
                            DataPoint<double>(value: 35, xAxis: 10),
                            DataPoint<double>(value: 40, xAxis: 15),
                            DataPoint<double>(value: 40, xAxis: 20),
                            DataPoint<double>(value: 40, xAxis: 25),
                            DataPoint<double>(value: 9, xAxis: 30),
                            DataPoint<double>(value: 11, xAxis: 35),
                          ],
                        ),
                      ],
                      config: BezierChartConfig(
                        verticalIndicatorStrokeWidth: 2.0,
                        verticalIndicatorColor: Colors.black,
                        xAxisTextStyle: TextStyle(color: Colors.black),
                        showVerticalIndicator: true,
                        bubbleIndicatorColor: Colors.black,
                        contentWidth: MediaQuery.of(context).size.width,
                        backgroundColor: Color.fromRGBO(153, 28, 209, 0),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
        ),
        BottomMenu()
      ]
    ),
  ); 
}