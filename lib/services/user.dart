import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sauron/models/user.dart' as Models;

// Future<void> createUser(Models.User user) async {
//   CollectionReference users = FirebaseFirestore.instance.collection('Users');

//   FirebaseApp app = await Firebase.initializeApp(
//       name: 'Secondary', options: Firebase.app().options);
//   try {
//     UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
//         .createUserWithEmailAndPassword(
//             email: user.email, password: user.password);
//     await app.delete();

//     await users.add({'email': user.email, 'password': user.password}).then(
//         (doc) => Future.sync(() => user));
//   } on FirebaseAuthException catch (e) {}
// }

Future<Models.User> getUser(String userId) async {
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('Users').doc(userId).get();

  Models.User user = new Models.User(
      userId, doc.data()["accountId"], doc.data()["displayName"]);

  return user;
}
