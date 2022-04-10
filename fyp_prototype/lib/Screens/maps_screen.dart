import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_prototype/Screens/maps_marker_detail_screen.dart';
import 'package:fyp_prototype/main.dart';
import 'package:fyp_prototype/providers/complaint_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  Function getUserId = () {};
  GoogleMapsScreen(this.getUserId);
  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = LatLng(31.48196985, 74.32249475);

  late BitmapDescriptor customIcon;

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  final MapType _currentMapType = MapType.normal;

  late var locationsList = [];

  String _darkMapStyle = '';

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/dark_mode.json');
  }

  @override
  void initState() {
    () async {
      //Center should not be in the marker list becuase it is not a complaint
      /*_markers.add(
        const Marker(
            markerId: MarkerId('center'),
            position: _center,
            icon: BitmapDescriptor.defaultMarker),
      );*/
      ComplaintProvider complaintProvider = ComplaintProvider(
        FirebaseDatabase.instanceFor(
            app: firebaseApp,
            databaseURL:
                'https://fyp-project-98f0f-default-rtdb.asia-southeast1.firebasedatabase.app'),
        widget.getUserId,
      );
      locationsList = await complaintProvider.FilterComplaintsByUserId();
      for (var item in locationsList) {
        final latitude = item['latitude'];
        final longitude = item['longitude'];
        final uid = item['uid'];
        final time = item['dateTime'];

        if (await widget.getUserId() == uid) {
          _markers.add(
            Marker(
              markerId: MarkerId('$latitude$longitude$uid${time.toString()}'),
              position: LatLng(
                item['latitude'],
                item['longitude'],
              ),
              icon: BitmapDescriptor.defaultMarker,
              onTap: () => goToMakerScreen(
                latitude,
                longitude,
                uid,
                time,
                item['status'],
              ),
            ),
          );
        }
      }
    }();
    _onAddMarkerButtonPressed();
    super.initState();
  }

  void goToMakerScreen(
    double lat,
    double long,
    String uid,
    DateTime dateTime,
    String status,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MapsMarkerDetailScreen(lat, long, uid, dateTime, status),
      ),
    );
  }

  void _onAddMarkerButtonPressed() async {
    ComplaintProvider complaintProvider = ComplaintProvider(
      FirebaseDatabase.instanceFor(
          app: firebaseApp,
          databaseURL:
              'https://fyp-project-98f0f-default-rtdb.asia-southeast1.firebasedatabase.app'),
      widget.getUserId,
    );
    locationsList = await complaintProvider.FilterComplaintsByUserId();
    setState(() {
      for (var item in locationsList) {
        final latitude = item['latitude'];
        final longitude = item['longitude'];
        final uid = item['uid'];
        final time = item['dateTime'];

        if (widget.getUserId() == uid) {
          _markers.add(
            Marker(
              markerId: MarkerId('$latitude$longitude$uid${time.toString()}'),
              position: LatLng(
                item['latitude'],
                item['longitude'],
              ),
              icon: customIcon,
              onTap: () => goToMakerScreen(
                latitude,
                longitude,
                uid,
                time,
                item['status'],
              ),
            ),
          );
        }
      }
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    () async {
      await _loadMapStyles();
      controller.setMapStyle(_darkMapStyle);
      _controller.complete(controller);
    }();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Complaints Locations',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: const Color(0xFFCCFF00),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              compassEnabled: true,
              initialCameraPosition: const CameraPosition(
                target: _center,
                zoom: 12.5,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
          ],
        ),
      ),
    );
  }
}
