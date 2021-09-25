import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:sauron/models/bezier_line.dart';
import 'package:sauron/models/incident.dart';
import 'package:http/http.dart' as http;
import "package:collection/collection.dart";

final String endpoint =
    'http://52.67.64.156:1026/v2/entities?type=incident&since=';
final Map<String, String> headers = {
  "Accept": "application/json",
  "fiware-service": "helixiot"
};

class IncidentService {
  static List<PointData> getIncidentsByDate(accountId,
      {since, IncidentType? type}) {
    String params = "";
    if (since != null) {
      params += DateTime.now().toString() + "&";
    }
    if (type != null) {
      params += type.toString().split(".").last + "&";
    }

    // http.Response response =
    //     await http.get("${endpoint + since}", headers: headers);

    // return parseIncident(response);

    if (type == IncidentType.missing_part) {
      return toPointDataList(json.encode([
        {
          "type": "missing_part",
          "captured_at": "2019-01-22T22:39:35.524355+00:00",
        },
        {
          "type": "missing_part",
          "captured_at": "2019-01-22T22:39:35.524355+00:00",
        },
        {
          "type": "missing_part",
          "captured_at": "2019-01-23T22:39:35.524355+00:00",
        },
        {
          "type": "missing_part",
          "captured_at": "2019-01-23T22:39:35.524355+00:00",
        },
        {
          "type": "missing_part",
          "captured_at": "2019-01-24T22:39:35.524355+00:00",
        },
        {
          "type": "missing_part",
          "captured_at": "2019-01-24T22:39:35.524355+00:00",
        },
        {
          "type": "missing_part",
          "captured_at": "2019-01-24T22:39:35.524355+00:00",
        },
        {
          "type": "missing_part",
          "captured_at": "2019-01-24T22:39:35.524355+00:00",
        },
      ]));
    } else {
      return toPointDataList(json.encode([
        {
          "type": "anomaly",
          "captured_at": "2019-01-22T22:39:35.524355+00:00",
        },
        {
          "type": "anomaly",
          "captured_at": "2019-02-23T22:39:35.524355+00:00",
        },
        {
          "type": "anomaly",
          "captured_at": "2019-02-23T22:39:35.524355+00:00",
        },
        {
          "type": "anomaly",
          "captured_at": "2019-02-23T22:39:35.524355+00:00",
        },
        {
          "type": "anomaly",
          "captured_at": "2019-02-23T22:39:35.524355+00:00",
        },
        {
          "type": "anomaly",
          "captured_at": "2019-05-24T22:39:35.524355+00:00",
        },
        {
          "type": "anomaly",
          "captured_at": "2019-05-24T22:39:35.524355+00:00",
        },
        {
          "type": "anomaly",
          "captured_at": "2019-05-24T22:39:35.524355+00:00",
        },
      ]));
    }
  }

  static List<Incident> parse(http.Response raw) {
    return List<Incident>.from(
        json.decode(raw.body).map((item) => parseIncident(item)));
  }

  static List<PointData> toPointDataList(raw) {
    Map<String, int> dateToCount = new Map<String, int>();
    List<PointData> pointDataList = [];

    for (var item in json.decode(raw)) {
      String referenceDate =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(item["captured_at"]));

      if (dateToCount.containsKey(referenceDate)) {
        dateToCount[referenceDate] = (dateToCount[referenceDate])!+ 1;
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
    return json.decode(raw).map((inc) => Incident(type: inc["type"], timestamp: inc["captured_at"]));
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
