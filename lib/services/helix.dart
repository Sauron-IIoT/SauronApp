import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:sauron/models/bezier_line.dart';
import 'package:sauron/models/classification.dart';
import 'package:http/http.dart' as http;
import "package:collection/collection.dart";

final String endpoint =
    'http://52.67.64.156:1026/v2/entities?limit=1000&options=keyValues&q=captured_at>';
final Map<String, String> headers = {
  "Accept": "application/json",
  "fiware-service": "helixiot"
};

class HelixService {
  static Future<Map<dynamic, List<dynamic>>> getCaptures(accountId,
      {DateTime? since, ClassificationType? type}) async {
    var body = [];
    var offset = 0;
    while (true) {
      http.Response response = await http.get(
          "${endpoint + since!.toIso8601String() + '+00:00'}&offset=$offset",
          headers: headers);

      if (response.statusCode > 202) return {'error': []};
      if (response.body == '[]') break;

      body.addAll(json.decode(response.body));
      offset += 1000;
    }

    Map<dynamic, List<dynamic>> mappedBody =
        groupBy(body, (item) => item?['type']);

    for (var key in mappedBody.keys) {
      mappedBody[key] = toPointDataList(mappedBody[key]);
    }
    return mappedBody;
  }

  static List<Incident> parse(http.Response raw) {
    return List<Incident>.from(
        json.decode(raw.body).map((item) => parseIncident(item)));
  }

  static List<PointData> toPointDataList(items) {
    Map<String, int> dateToCount = new Map<String, int>();
    List<PointData> pointDataList = [];

    for (var item in items) {
      String referenceDate =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(item["captured_at"]));

      if (dateToCount.containsKey(referenceDate)) {
        dateToCount[referenceDate] = (dateToCount[referenceDate])! + 1;
      } else {
        dateToCount[referenceDate] = 1;
      }
    }

    dateToCount.forEach((key, value) {
      pointDataList.add(parsePointData(key, value));
    });

    return pointDataList;
  }

  static Incident toIncidentList(raw) {
    return json.decode(raw).map(
        (inc) => Incident(type: inc["type"], timestamp: inc["captured_at"]));
  }

  static Incident parseIncident(item) {
    return Incident(type: item["type"], timestamp: item["captured_at"]);
  }

  static PointData parsePointData(date, rowCount) {
    return PointData(DateTime.parse(date), double.parse(rowCount.toString()));
  }
}

class IncidentResponse {
  List<RawIncident>? incidents;
}

class RawIncident {
  String? type;
  DateTime? captured_at;
}
