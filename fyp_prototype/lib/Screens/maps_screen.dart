import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

  static const LatLng _center = LatLng(31.5272978, 74.306884);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  final MapType _currentMapType = MapType.normal;

  late var locationsList = [];

  @override
  void initState() {
    () async {
      ComplaintProvider complaintProvider = ComplaintProvider(
        FirebaseDatabase.instanceFor(
            app: firebaseApp,
            databaseURL:
                'https://fyp-project-98f0f-default-rtdb.asia-southeast1.firebasedatabase.app'),
        widget.getUserId,
      );
      locationsList = await complaintProvider.FilterComplaintsByUserId();
      /*for (var item in locationsList) {
        print('Boy: ' + item.toString());
        final latitude = item['latitude'];
        final longitude = item['longitude'];
        final uid = item['uid'];
        final time = item['dateTime'].toString();

        _markers.add(Marker(
          markerId: MarkerId('$latitude$longitude$uid$time'),
          position: LatLng(
            item['latitude'],
            item['longitude'],
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
      }*/
      _markers.add(const Marker(
        markerId: MarkerId('something'),
        position: LatLng(32.5272978, 74.306884),
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
    }();
    super.initState();
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
        _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(_lastMapPosition.toString()),
          position: LatLng(
            item['latitude'],
            item['longitude'],
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
      }
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Complaints Locations'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: _center,
                zoom: 14.5,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            FloatingActionButton(
              onPressed: _onAddMarkerButtonPressed,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: Colors.green,
              child: const Icon(Icons.add_location, size: 36.0),
            ),
          ],
        ),
      ),
    );
  }
}
