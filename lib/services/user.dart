import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sauron/models/user.dart' as Models;

Future<Models.User> getUser(String userId) async {
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('Users').doc(userId).get();

  Models.User user = new Models.User(
      userId, doc.data()["accountId"], doc.data()["displayName"]);

  return user;
}
