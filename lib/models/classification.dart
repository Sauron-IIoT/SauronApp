enum ClassificationType { none, knownPart, anomaly }

class Incident {
  // {
  //   "id": "urn:ngsi-ld:capture:831632ac-2588-4b3f-8737-74ed4ff0bddb",
  //   "type": "capture",
  //   "captured_at": "2021-09-10T22:39:35.524355+00:00",
  //   "classification_score": 0.070501989,
  //   "uuid": "831632ac-2588-4b3f-8737-74ed4ff0bddb"
  // }

  ClassificationType type;
  DateTime? timestamp;
  double? confidence;

  Incident({this.type = ClassificationType.none, this.confidence, this.timestamp});
}
