import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sproggy/Config/emulator_config.dart';
import 'package:sproggy/firebase_options.dart';
import 'package:sproggy/routes/route_generator.dart';
import 'package:sproggy/Config/emulator_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    await _connectToFirebaseAuth();
    await _connectToFirebaseFirestore();
    await _connectToFirebaseStorage();
    await _connectToFirebaseRealtime();
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';
const Port = {
  "firebaseAuth": 9099,
  "fireStore": 8080,
  "firebaseStorage": 9199,
  "firebaseRealtime": 9000
};

Future<void> _connectToFirebaseAuth() async {
  FirebaseAuth.instance.useAuthEmulator(localHostString, Port["firebaseAuth"]!);
  debugPrint(
      'Connected to Firebase Auth emulator on: $localHostString:$Port["firebaseAuth"]');
}

Future<void> _connectToFirebaseFirestore() async {
  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:$Port["fireStore"]',
    sslEnabled: false,
    persistenceEnabled: false,
  );
  FirebaseAuth.instance.useAuthEmulator(localHostString, Port["fireStore"]!);
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sproggy',
      theme: ThemeData.light(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
