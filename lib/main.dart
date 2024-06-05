import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:niyejan/Screens/lgin.dart';
import 'package:niyejan/Screens/reg.dart';
import 'package:niyejan/mainpage.dart';

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
  ); //initializing firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Brand-Regular',
      ),
      initialRoute: RegistrationPage.id,
      routes: {
        RegistrationPage.id: (context) => RegistrationPage(),
        Lgin.id: (context) => Lgin(),
        Mainpage.id: (context) => Mainpage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
