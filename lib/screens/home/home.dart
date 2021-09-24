import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sauron/components/background/home.dart';
import 'package:sauron/components/bottom_menu/bottom_menu.dart';
import 'package:sauron/components/tab.dart';
import 'package:sauron/models/bezier_line.dart';
import 'package:sauron/models/event.dart';
import 'package:sauron/screens/home/args.dart';
import 'package:sauron/services/incident.dart';
import "package:collection/collection.dart";

class HomeScreen extends StatefulWidget {
  final List<DataPoint<DateTime>> missing = [];
  final List<DataPoint<DateTime>> anomaly = [];

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  PageController? _pageController;
  int _selectedPage = 0;

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
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as HomeArguments;

    getChartData(args.account_id, IncidentType.missing_part).then((data) {
      setState(() {
        widget.missing.addAll(data);
      });
    });

    getChartData(args.account_id, IncidentType.anomaly).then((data) {
      setState(() {
        widget.anomaly.addAll(data);
      });
    });

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
                      'Olá, ${args.display_name}',
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
                          text: 'Capturas',
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
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: BezierChart(
        fromDate: DateTime(2019, 01, 22),
        bezierChartScale: BezierChartScale.MONTHLY,
        toDate: DateTime(2019, 10, 22),
        series: [
          BezierLine(
              lineColor: Color.fromRGBO(153, 28, 209, 1),
              label: "Ausencia",
              data: widget.missing),
          BezierLine(
            lineColor: Colors.blue,
            label: "Peça estranha",
            data: widget.anomaly,
          ),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 2.0,
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
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: BezierChart(
        fromDate: DateTime(2019, 01, 22),
        bezierChartScale: BezierChartScale.MONTHLY,
        toDate: DateTime(2019, 12, 22),
        series: [
          BezierLine(
            lineColor: Color.fromRGBO(153, 28, 209, 1),
            label: "Peça 1",
            data: [
              DataPoint<DateTime>(value: 10, xAxis: DateTime(2019, 01, 22)),
              DataPoint<DateTime>(value: 130, xAxis: DateTime(2019, 02, 22)),
              DataPoint<DateTime>(value: 50, xAxis: DateTime(2019, 03, 22)),
              DataPoint<DateTime>(value: 150, xAxis: DateTime(2019, 04, 22)),
              DataPoint<DateTime>(value: 75, xAxis: DateTime(2019, 05, 22)),
              DataPoint<DateTime>(value: 0, xAxis: DateTime(2019, 06, 22)),
              DataPoint<DateTime>(value: 5, xAxis: DateTime(2019, 07, 22)),
              DataPoint<DateTime>(value: 45, xAxis: DateTime(2019, 08, 22)),
            ],
          ),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 2.0,
          verticalIndicatorColor: Colors.black,
          xAxisTextStyle: TextStyle(color: Colors.black, fontSize: 12),
          yAxisTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 10,
          ),
          showVerticalIndicator: true,
          displayYAxis: true,
          bubbleIndicatorColor: Colors.white,
          backgroundColor: Color.fromRGBO(153, 28, 209, 0),
        ),
      ),
    );
  }

  Future<List<DataPoint<DateTime>>> getChartData(accountId, type) async {
     await IncidentService.getIncidents(accountId, type: type), (item) => item.);


    return List<DataPoint<DateTime>>.from(
        (await IncidentService.getIncidentsByDate(accountId, type: type, since:  DateTime.now())).map(
            (incident) => DataPoint<DateTime>(xAxis: ))
    );
  }
}
