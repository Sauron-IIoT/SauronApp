import 'dart:convert';

import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sauron/components/background/home.dart';
import 'package:sauron/components/bottom_menu/bottom_menu.dart';
import 'package:sauron/components/tab.dart';
import 'package:sauron/models/bezier_line.dart';
import 'package:sauron/models/classification.dart';
import 'package:sauron/screens/home/args.dart';
import 'package:sauron/services/helix.dart';
import "package:collection/collection.dart";

class HomeScreen extends StatefulWidget {
  // So far is not dynamic, but we are already fetching records dynamically
  final List<DataPoint<DateTime>> engine = [
    new DataPoint(xAxis: DateTime.now(), value: 0)
  ];
  final List<DataPoint<DateTime>> esp32 = [
    new DataPoint(xAxis: DateTime.now(), value: 0)
  ];
  final List<DataPoint<DateTime>> anomaly = [
    new DataPoint(xAxis: DateTime.now(), value: 0)
  ];

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  PageController? _pageController;
  int _selectedPage = 0;
  HomeArguments? args;

  void _changeChart(int nextPage) {
    setState(() {
      this._selectedPage = nextPage;
      this._pageController!.animateToPage(nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
    getChartData(args?.account_id, ClassificationType.knownPart).then((data) {
      if (data.isNotEmpty) {
        setState(() {
          if (data.containsKey('esp32'))
            widget.esp32.addAll(data['esp32'] as List<DataPoint<DateTime>>);
          if (data.containsKey('motor'))
            widget.engine.addAll(data['motor'] as List<DataPoint<DateTime>>);
          if (data.containsKey('esp32'))
            widget.anomaly.addAll(
                data['prediction_failure'] as List<DataPoint<DateTime>>);

          print(widget.esp32);
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as HomeArguments;

    return Material(
      type: MaterialType.transparency,
      child: Stack(alignment: Alignment.center, children: <Widget>[
        HomeBackground(),
        Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Text(
                      'Olá, ${args?.display_name}',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 30,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        ChartTab(
                          text: 'Incidentes',
                          pageNumber: 0,
                          selectedPage: _selectedPage,
                          onTap: () {
                            _changeChart(0);
                          },
                        ),
                        ChartTab(
                          text: 'Peças',
                          pageNumber: 1,
                          selectedPage: _selectedPage,
                          onTap: () {
                            _changeChart(1);
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.infinity,
                    child: PageView(
                      physics: new NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: [
                        _buildDailyChart(context),
                        _buildMonthyChart(context),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
        BottomMenu()
      ]),
    );
  }

  Container _buildDailyChart(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: BezierChart(
        fromDate: DateTime.now().add(Duration(days: -30)),
        bezierChartScale: BezierChartScale.WEEKLY,
        toDate: DateTime.now(),
        series: [
          BezierLine(
              lineColor: Color.fromRGBO(153, 28, 209, 1),
              label: "Incidentes",
              onMissingValue: (dateTime) {
                return 0.0;
              },
              data: widget.anomaly),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 2.0,
          displayYAxis: true,
          stepsYAxis: 500,
          verticalIndicatorColor: Colors.black,
          xAxisTextStyle: TextStyle(color: Colors.black, fontSize: 12),
          bubbleIndicatorColor: Colors.white,
          showDataPoints: true,
          backgroundColor: Color.fromRGBO(153, 28, 209, 0),
        ),
      ),
    );
  }

  Container _buildMonthyChart(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: BezierChart(
        fromDate: DateTime.now().add(Duration(days: -30)),
        bezierChartScale: BezierChartScale.WEEKLY,
        toDate: DateTime.now(),
        series: [
          BezierLine(
              lineColor: Color.fromRGBO(153, 28, 209, 1),
              label: "ESP32",
              onMissingValue: (dateTime) {
                return 0.0;
              },
              data: widget.esp32),
          BezierLine(
              lineColor: Color.fromRGBO(0, 28, 209, 1),
              label: "Motor",
              onMissingValue: (dateTime) {
                return 0.0;
              },
              data: widget.engine),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 2.0,
          displayYAxis: true,
          stepsYAxis: 500,
          verticalIndicatorColor: Colors.black,
          xAxisTextStyle: TextStyle(color: Colors.black, fontSize: 12),
          bubbleIndicatorColor: Colors.white,
          showDataPoints: true,
          backgroundColor: Color.fromRGBO(153, 28, 209, 0),
        ),
      ),
    );
  }

  Future<Map<dynamic, List<DataPoint<DateTime>>>> getChartData(
      accountId, ClassificationType type) async {
    Map<dynamic, List<DataPoint<DateTime>>> dataPoints = {};

    return HelixService.getCaptures(accountId,
            type: type, since: DateTime.now().add(Duration(days: -90)))
        .then((results) {
      results.forEach((key, list) => dataPoints[key] = list.map((item) =>
              DataPoint<DateTime>(xAxis: item.date, value: item.value)).toList()
          as List<DataPoint<DateTime>>);
      print('DP => ' + dataPoints.toString());
      return dataPoints;
    });
  }
}
