import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';
const Port = {
  "firebaseAuth": 9099,
  "fireStore": 8080,
  "firebaseStorage": 9199,
  "firebaseRealtime": 9000
};

Future<void> _connectToFirebaseFirestore() async {
  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:$Port["fireStore"]',
    sslEnabled: false,
    persistenceEnabled: false,
  );
  FirebaseAuth.instance.useAuthEmulator(localHostString, Port["fireStore"]!);
}

Future<void> _connectToFirebaseAuth() async {
  FirebaseAuth.instance.useAuthEmulator(localHostString, Port["firebaseAuth"]!);
  debugPrint(
      'Connected to Firebase Auth emulator on: $localHostString:$Port["firebaseAuth"]');
}

Future<void> _connectToFirebaseStorage() async {
  FirebaseStorage.instanceFor(
    app: FirebaseStorage.instance.app,
    bucket: '$localHostString:$Port["firebaseStorage"]',
  );
  debugPrint(
      'Connected to Firebase Storage emulator on: $localHostString:$Port["firebaseStorage"]');
}

Future<void> _connectToFirebaseRealtime() async {
  FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL: '$localHostString:$Port["firebaseRealtime"]');
  debugPrint(
      'Connected to Firebase Realtime Database emulator on: $localHostString:$Port["firebaseRealtime"]');
}
