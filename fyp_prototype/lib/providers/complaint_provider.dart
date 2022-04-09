import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp_prototype/models/complaint.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ComplaintProvider {
  Function getUserId = () {};
  final FirebaseDatabase _firebaseDatabase;

  ComplaintProvider(this._firebaseDatabase, this.getUserId);

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
      final _firebaseStorage = FirebaseStorage.instanceFor(
          bucket: "gs://fyp-project-98f0f.appspot.com");
      var file = File(complaint.imageFile.path);

      final longitude = data['longitude'];
      final latitude = data['latitude'];
      final uid = data['uid'];
      final time = data['dateTime'].toString();

      var snapshot = await _firebaseStorage
          .ref()
          .child('images/$longitude$latitude$uid$time')
          .putFile(file);

      await snapshot.ref.getDownloadURL().then((value) async {
        data['imageUrl'] = value;
        await _firebaseDatabase.ref().child("complaints").push().set(data);
      });
      return "Complaint Registered!";
    } catch (e) {
      print('Error: $e');
      return e.toString();
    }
  }

  Future<List<dynamic>> getAllComplaint() async {
    try {
      DatabaseEvent event = await _firebaseDatabase.ref('complaints').once();
      List<dynamic> res = [];
      for (var element in event.snapshot.children) {
        res.add(element.value);
      }
      return res;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<dynamic>> FilterComplaintsByUserId() async {
    try {
      List<dynamic> complaintsList = await getAllComplaint();
      List<dynamic> filteredList = [];
      final userId = await getUserId();
      for (var complaint in complaintsList) {
        if (complaint['uid'] == userId) {
          filteredList.add(complaint);
        }
      }
      return filteredList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
