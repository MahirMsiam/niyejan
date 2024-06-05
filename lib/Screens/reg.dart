// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:niyejan/Widget/TaxiButton.dart';
import 'package:niyejan/brand_colors.dart';

// ignore: use_key_in_widget_constructors
class RegistrationPage extends StatelessWidget {
  static const String id = 'register';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  Future<User?> createUserWithEmailAndPassword(
      String email, String password, String fullname, String phone) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? newUser = userCredential.user;
      if (newUser != null) {
        await newUser.updateProfile(displayName: fullname);
        await newUser.reload();
        User? updatedUser = _auth.currentUser;
        return updatedUser;
        print('User created');
      }
      return newUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

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
                'Create a Rider\'s Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    // Full Name
                    TextField(
                      controller: fullnameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
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
                    // Phone Number
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'phone number',
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
                    // Email
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
                    // Password
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
                      title: 'REGISTER',
                      color: BrandColors.colorGreen,
                      onPressed: () {
                        // Check for valid inputs
                        if (fullnameController.text.length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please provide a valid name'),
                            ),
                          );
                          return;
                        }

                        if (phoneController.text.length < 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Please provide a valid phone number'),
                            ),
                          );
                          return;
                        }
                        if (!emailController.text.contains('@')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Please provide a valid email address'),
                            ),
                          );
                          return;
                        }
                        if (passwordController.text.length < 8) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please provide a valid password'),
                            ),
                          );
                          return;
                        }
                        createUserWithEmailAndPassword(
                            emailController.text,
                            passwordController.text,
                            fullnameController.text,
                            phoneController.text);
                      },
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'login', (route) => false);
                },
                child: Text('Already have a Rider account? Log in'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
