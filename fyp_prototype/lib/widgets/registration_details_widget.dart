import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp_prototype/Screens/user_dashboard.dart';
import 'package:fyp_prototype/main.dart';
import 'package:fyp_prototype/models/complaint.dart';
import 'package:fyp_prototype/providers/complaint_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart' as loc;
import 'package:intl/intl.dart';

class RegistationDetailsWidget extends StatefulWidget {
  File? _image;
  Function signout = () {};
  Function getuserid = () {};
  RegistationDetailsWidget(File i, Function sout, Function getuid) {
    _image = i;
    signout = sout;
    getuserid = getuid;
  }

  @override
  State<RegistationDetailsWidget> createState() =>
      _RegistationDetailsWidgetState();
}

class _RegistationDetailsWidgetState extends State<RegistationDetailsWidget> {
  final loc.Location location = loc.Location();
  Geolocator geolocator = Geolocator();
  late Position userLocation;
  String _address = "";
  double _latitude = 0.0, _longitude = 0.0;
  String _city = "", _country = "", _state = "", _zipCode = "";

  Future<List<geo.Placemark>> _getAddress(double? lat, double? lang) async {
    //final coordinates = new Coordinates(lat, lang);
    List<geo.Placemark> placemarks =
        await geo.placemarkFromCoordinates(lat!, lang!);
    return placemarks;
  }

  getLoc() async {
    var currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    //print(
    //'Latitude: ${currentLocation.latitude}, Longitude: ${currentLocation.longitude}');

    //_currentPosition = await location.getLocation();
    _getAddress(currentLocation.latitude, currentLocation.longitude)
        .then((value) {
      setState(() {
        _latitude = currentLocation.latitude;
        _longitude = currentLocation.longitude;
        _address = "${currentLocation.latitude}, ${currentLocation.longitude}";
      });

      _latitude = currentLocation.latitude;
      _longitude = currentLocation.longitude;
      _city = value.first.locality.toString();
      _country = value.first.country.toString();
      _state = value.first.administrativeArea.toString();
      _zipCode = value.first.postalCode.toString();
    });
    return _address;
  }

  @override
  void initState() {
    super.initState();
    getLoc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF2C3539),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(widget._image!),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25, left: 25, bottom: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Date: ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25, left: 25, bottom: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Time: ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                DateFormat('hh:mm a').format(DateTime.now()),
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25, left: 25, bottom: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Location: ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                _address == "" ? "" : _address,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserDashboard(widget.signout, widget.getuserid),
                    ),
                  );
                },
                child: const Text('cancel',
                    style: TextStyle(color: Colors.blue, fontSize: 16)),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xFFCCFF00),
                  ),
                ),
                onPressed: () {
                  ComplaintProvider complaintProvider = ComplaintProvider(
                    FirebaseDatabase.instanceFor(
                        app: firebaseApp,
                        databaseURL:
                            'https://fyp-project-98f0f-default-rtdb.asia-southeast1.firebasedatabase.app'),
                    widget.getuserid,
                  );
                  widget.getuserid().then((uid) {
                    complaintProvider
                        .registerComplaint(
                          Complaint(
                            lat: _latitude,
                            long: _longitude,
                            dateT: DateTime.now(),
                            stat: 'Registered',
                            userid: uid,
                            imgFile: widget._image,
                          ),
                        )
                        .then((value) => {
                              if (value == '')
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'Complaint successfully registered'),
                                      action: SnackBarAction(
                                        label: 'Okay',
                                        onPressed: () {},
                                      ),
                                    ),
                                  )
                                },
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserDashboard(
                                    widget.signout,
                                    widget.getuserid,
                                  ),
                                ),
                              )
                            });
                  });
                },
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
