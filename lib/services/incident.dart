import 'dart:convert';

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
  static Future<List<Incident>> getIncidentsByDate(accountId,
      {since, IncidentType? type}) async {
    String params = "";
    if (since != null) {
      params += DateTime.now().toString() + "&";
    }
    if (type != null) {
      params += type.toString().split(".").last + "&";
    }

    // http.Response response =
    //     await http.get("${endpoint + since}", headers: headers);

    // return parse(response);

    await Future.delayed(Duration(seconds: 3));
    if (type == IncidentType.missing_part) {
      return [
        Incident(
            type: IncidentType.missing_part, timestamp: DateTime(2019, 01, 22)),
        Incident(
            type: IncidentType.missing_part, timestamp: DateTime(2019, 01, 22)),
        Incident(
            type: IncidentType.missing_part, timestamp: DateTime(2019, 01, 24)),
        Incident(
            type: IncidentType.missing_part, timestamp: DateTime(2019, 01, 24)),
        Incident(
            type: IncidentType.missing_part, timestamp: DateTime(2019, 01, 24)),
        Incident(
            type: IncidentType.missing_part, timestamp: DateTime(2019, 01, 24)),
        Incident(
            type: IncidentType.missing_part, timestamp: DateTime(2019, 01, 27)),
        Incident(
            type: IncidentType.missing_part, timestamp: DateTime(2019, 01, 27)),
      ];
    } else {
      return [
        Incident(
            type: IncidentType.anomaly, timestamp: DateTime(2019, 01, 22)),
        Incident(
            type: IncidentType.anomaly, timestamp: DateTime(2019, 01, 22)),
        Incident(
            type: IncidentType.anomaly, timestamp: DateTime(2019, 01, 22)),
        Incident(
            type: IncidentType.anomaly, timestamp: DateTime(2019, 01, 22)),
        Incident(
            type: IncidentType.anomaly, timestamp: DateTime(2019, 01, 26)),
        Incident(
            type: IncidentType.anomaly, timestamp: DateTime(2019, 01, 26)),
        Incident(
            type: IncidentType.anomaly, timestamp: DateTime(2019, 01, 26)),
        Incident(
            type: IncidentType.anomaly, timestamp: DateTime(2019, 01, 26)),
      ];
    }
  }

  static List<Incident> parse(http.Response raw) {
    return List<Incident>.from(
        json.decode(raw.body).map((item) => parseResponseItem(item)));
  }

  // static List<Incident> parseSummary(http.Response raw) {
  //   return List<Incident>.from(
  //       groupBy(json.decode(raw.body)).map((item) => parseResponseItem(item)));
  // }

  static Incident parseResponseItem(item) {
    return Incident(type: item["type"], timestamp: item["captured_at"]);
  }
}

class IncidentResponse {
  List<RawIncident>? incidents;
}

class RawIncident {
  String? type;
  DateTime? captured_at;
}
