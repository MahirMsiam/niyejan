import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:niyejan/MainPage.dart';

// ignore: constant_identifier_names
const USE_DATABASE_EMULATOR = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'db2',
    options: const FirebaseOptions(
      appId: '1:506053574785:android:9033e6647524ccd273cd80',
      messagingSenderId: '297855924061',
      projectId: 'niyejan-97e62',
      apiKey: 'AIzaSyCaMFfAl5w7sABJc5sepOvWyYHOVXhgyYQ',
      databaseURL: USE_DATABASE_EMULATOR
          ? 'http://localhost:9000'
          : 'https://niyejan-97e62-default-rtdb.firebaseio.com',
    ),
  );//initializing firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          //primarySwatch: Colors.blue,
          ),
      home: const Mainpage(),
    );
  }
}
