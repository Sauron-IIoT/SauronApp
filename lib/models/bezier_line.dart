import 'package:flutter/material.dart';

class BezierLineData {
  Color color;
  String label;
  List<PointData> data;

  BezierLineData(this.color, this.label, this.data);

  Map<String, dynamic> toJson() =>
      {'color': color, 'accountId': label, 'userId': data.toString()};
}

class PointData {
  DateTime date;
  double value;

  PointData(this.date, this.value);
}
