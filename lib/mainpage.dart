// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:niyejan/Widget/BrandDivider.dart';
import 'package:niyejan/brand_colors.dart';
import 'package:niyejan/styles/style.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class Mainpage extends StatefulWidget {
  static const String id = 'mainpage';
  Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double mapBottomPadding = 0;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late GoogleMapController mapController;
  double searchSheetHeight = (Platform.isIOS) ? 300 : 275;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        width: 250,
        color: Colors.white,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Container(
                height: 160,
                color: Colors.white,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'images/user_icon.png',
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Profile Name',
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'Brand-Bold'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Branddivider(),
              SizedBox(height: 10,),
              ListTile(
                leading: Icon(OMIcons.cardGiftcard),
                title: Text('Free Rides', style: kDrawerItemStyle,),
              ),
              ListTile(
                leading: Icon(OMIcons.creditCard),
                title: Text('Payments', style: kDrawerItemStyle,),
              ),
              ListTile(
                leading: Icon(OMIcons.history),
                title: Text('Ride History', style: kDrawerItemStyle,),
              ),
              ListTile(
                leading: Icon(OMIcons.contactSupport),
                title: Text('Support', style: kDrawerItemStyle,),
              ),
              ListTile(
                leading: Icon(OMIcons.info),
                title: Text('About', style: kDrawerItemStyle,),
              ),


            ],
          ),
        ),
      ),
      body: Center(
          child: Stack(children: <Widget>[
        GoogleMap(
          padding: EdgeInsets.only(bottom: mapBottomPadding),
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            mapController = controller;
            setState(() {
              mapBottomPadding = (Platform.isAndroid) ? 280 : 270;
            });
          },
        ),
        //Menu Button
        Positioned(
          top: 44,
          left: 20,
          child: GestureDetector(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7))
                  ]),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(Icons.menu),
              ),
            ),
          ),
        ),




        //Search Sheet//
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: searchSheetHeight,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.4,
                    offset: Offset(0.7, 0.7),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Hi there',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    'Where are you going',
                    style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Search Destination'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  //HOME
                  Row(
                    children: <Widget>[
                      Icon(
                        OMIcons.home,
                        color: BrandColors.colorDimText,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Add Home'),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Your residential address',
                            style: TextStyle(
                                fontSize: 11, color: BrandColors.colorDimText),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Branddivider(),
                  //WORK
                  Row(
                    children: <Widget>[
                      Icon(
                        OMIcons.workOutline,
                        color: BrandColors.colorDimText,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Add work'),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Your Office address address',
                            style: TextStyle(
                                fontSize: 11, color: BrandColors.colorDimText),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ])),
    );
  }
}
