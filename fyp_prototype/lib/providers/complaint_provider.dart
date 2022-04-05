import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

import 'package:firebase_database/firebase_database.dart';
import 'package:fyp_prototype/models/complaint.dart';

class ComplaintProvider {
  final FirebaseDatabase _firebaseDatabase;

  ComplaintProvider(this._firebaseDatabase);

  Future<String> registerComplaint(Complaint complaint) async {
    try {
      var data = {
        'uid': complaint.getUserId,
        'longitude': complaint.getLongitude,
        'latitude': complaint.getLatitude,
        'status': complaint.getStatus,
        'dateTime': complaint.getDateTime.toString(),
        'imageUrl': complaint.getImageUrl == '' ? '' : complaint.getImageUrl,
      };
      await _firebaseDatabase
          .ref()
          .child("complaints")
          .push()
          .set(data)
          .then((value) async {
        final _firebaseStorage = FirebaseStorage.instance;
        var file = File(complaint.imageFile.path);

        var snapshot = await _firebaseStorage
            .ref()
            .child('images/imageName')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
      });
      return "Complaint Registered!";
    } catch (e) {
      print('Error: $e');
      return e.toString();
    }
  }
}
