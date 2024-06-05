import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatefulWidget {
  static const String id = 'mainpage';
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Main Page'),
        backgroundColor: Color.fromARGB(255, 22, 146, 228)      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("message");
            dbRef.set("Connected to Firebase Database");
          },
          height: 50,
          minWidth: 300,
          color: Color.fromARGB(255, 16, 221, 95),
          child: const Text('Click Me'),
        ),
      ),
    );
  }
}