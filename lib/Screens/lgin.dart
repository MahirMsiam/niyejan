// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:niyejan/brand_colors.dart';
import 'package:niyejan/Widget/TaxiButton.dart';
import 'package:niyejan/Widget/progressdialogue.dart';

class Lgin extends StatefulWidget {
  Lgin({Key? key}) : super(key: key);
  static const String id = 'login';

  @override
  State<Lgin> createState() => _LginState();
}

class _LginState extends State<Lgin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  //method for user login using email and password
  void login() async {
    //show please wait dialogue
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Progressdialogue(
        status: 'Logging you in',
      ),
    );

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (userCredential.user != null) {
        //verify login
        DatabaseReference newUserRef = FirebaseDatabase.instance
            .ref()
            .child('users/${userCredential.user!.uid}');
        newUserRef.once().then((DatabaseEvent snapshot) {
          if (snapshot.snapshot.value != null) {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
                context, 'mainpage', (route) => false);
          }
        });
      }
      print('User: ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Wrong password provided for that user.'),
          ),
        );
      }
    } finally {
      Navigator.pop(context);
    }
  }

  //please wait dialogue

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Image(
                alignment: Alignment.center,
                height: 100,
                width: 100,
                image: AssetImage('images/logo.png'),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Login as a Rider',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TaxiButton(
                      title: 'LOGIN',
                      color: BrandColors.colorGreen,
                      onPressed: () async {
                        //check for network connectivity
                        // var connectivityResult =
                        //     await Connectivity().checkConnectivity();
                        // if (connectivityResult != ConnectivityResult.mobile &&
                        //     connectivityResult != ConnectivityResult.wifi) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text('No network connection'),
                        //     ),
                        //   );
                        //   return;
                        // }

                        // try {
                        //   final result =
                        //       await InternetAddress.lookup('google.com');
                        //   if (result.isEmpty || result[0].rawAddress.isEmpty) {
                        //     throw SocketException('No Internet');
                        //   }
                        //   // Internet connected
                        //   // Continue with your registration process
                        // } on SocketException catch (_) {
                        //   // No internet connected
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text('No internet connection'),
                        //     ),
                        //   );
                        //   return;
                        // }
                        //check end
                        //input validation
                        if (!emailController.text.contains('@')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Please enter a valid email address'),
                            ),
                          );
                          return;
                        }
                        if (!passwordController.text.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter a password'),
                            ),
                          );
                          return;
                        }
                        if (passwordController.text.length < 8) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Password must be at least 8 characters'),
                            ),
                          );
                          return;
                        }
                        //input validation end
                        login();
                      },
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'register', (route) => false);
                },
                child: Text('Do not have an account? Register Here'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
