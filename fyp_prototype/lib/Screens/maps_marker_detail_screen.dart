import 'package:flutter/material.dart';

class MapsMarkerDetailScreen extends StatelessWidget {
  double latitude = 0.0;
  double longtude = 0.0;
  String uid = '';
  String status = '';
  late DateTime dateTime;

  MapsMarkerDetailScreen(
      this.latitude, this.longtude, this.uid, this.dateTime, this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(uid),
      ),
    );
  }
}
