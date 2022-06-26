import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp_prototype/models/complaint.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vector_math/vector_math.dart' as vectorMath;
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ComplaintProvider {
  Function getUserId = () {};
  final FirebaseDatabase _firebaseDatabase;

  ComplaintProvider(this._firebaseDatabase, this.getUserId);

  Future<String> registerComplaint(Complaint complaint) async {
    try {
      /**
       * If the user has submitted a complaint 10 mins ago and 
       * the complaint is in the 10 meter raduis than decalre it as the same
       * complaint and no need to spam/submit it
       */
      /*DatabaseEvent event = await _firebaseDatabase.ref('complaints').once();
      List<dynamic> complaintsList = [];
      final userId = await getUserId();
      for (var element in event.snapshot.children) {
        complaintsList.add(element.value);
      }

      for (var element in complaintsList) {
        if (element['uid'] != userId) {
          complaintsList.remove(element);
        }
      }

      if (complaintsList.isNotEmpty) {
        DateTime latestDate = DateTime.parse(complaintsList[0]['dateTime']);
        for (int i = 1; i < complaintsList.length; i++) {
          if (latestDate
              .isBefore(DateTime.parse(complaintsList[i]['dateTime']))) {
            latestDate = DateTime.parse(complaintsList[i]['dateTime']);
          }
        }
      }
      DateTime date1 = DateTime.parse(complaint.getDateTime.toString());
      if (complaintsList.isNotEmpty) {
        if (complaintsList[0]['uid'] == userId &&
            complaintsList[0]['status'] == 'Registered') {
          DateTime date2 = DateTime.parse(complaintsList[0]['dateTime']);
          if (minutesBetween(date1, date2) < 10) {
            print('between: ' + minutesBetween(date1, date2).toString());
            if (distance(
                    complaintsList[0]['latitude'],
                    complaintsList[0]['longitude'],
                    complaint.getLatitude,
                    complaint.getLongitude) >
                10) {
              print('distance: ' +
                  distance(
                          complaintsList[0]['latitude'],
                          complaintsList[0]['longitude'],
                          complaint.getLatitude,
                          complaint.getLongitude)
                      .toString());
              var data = {
                'uid': complaint.getUserId,
                'longitude': complaint.getLongitude,
                'latitude': complaint.getLatitude,
                'status': complaint.getStatus,
                'dateTime': complaint.getDateTime.toString(),
                'imageUrl':
                    complaint.getImageUrl == '' ? '' : complaint.getImageUrl,
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
                await _firebaseDatabase
                    .ref()
                    .child("complaints")
                    .push()
                    .set(data);
              });
              print('Complaint Registered minutes < 10 distance > 10!');
              return "Complaint Registered!";
            } else {
              print('between: ' + minutesBetween(date1, date2).toString());
              print('distance: ' +
                  distance(
                          complaintsList[0]['latitude'],
                          complaintsList[0]['longitude'],
                          complaint.getLatitude,
                          complaint.getLongitude)
                      .toString());
              print('Same Location!');
              return 'Same location';
            }
          } else {
            //IF the minutes are greater than 10
            var data = {
              'uid': complaint.getUserId,
              'longitude': complaint.getLongitude,
              'latitude': complaint.getLatitude,
              'status': complaint.getStatus,
              'dateTime': complaint.getDateTime.toString(),
              'imageUrl':
                  complaint.getImageUrl == '' ? '' : complaint.getImageUrl,
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
              await _firebaseDatabase
                  .ref()
                  .child("complaints")
                  .push()
                  .set(data);
            });
            print('Complaint Registered minutes > 10!');
            return "Complaint Registered!";
          }
        }
      } else {
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
        print('Complaint Registered complaintsList == null!');
        return "Complaint Registered!";
      }*/

      var uuid = Uuid();
      String imageUrl = '';

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
          .child('images/${uuid.v4()}')
          .putFile(file);
      print(snapshot.ref.name);
      print(snapshot.ref.fullPath);
      print(snapshot.ref.parent);
      print(snapshot.ref.root);
      print(snapshot.ref.bucket);
      print(snapshot.ref.getDownloadURL());
      print(snapshot.ref.getData());
      print(snapshot.ref.getMetadata());
      await snapshot.ref.getDownloadURL().then((value) async {
        data['imageUrl'] = value;
        imageUrl = value;
      });

      String res = '';

      var baseUrl1 = 'http://192.168.1.102:8000';
      var baseUrl2 = 'http://127.0.0.1:8000';

      var urlDelFlies = Uri.parse(baseUrl1 + '/api/yolov5/delFiles');
      var delFiles = await http.get(urlDelFlies);

      if (delFiles == '1') {
        var urlGetImage = Uri.parse(baseUrl1 + '/api/getimg');
        var getImage = await http.get(urlGetImage);

        if (getImage == '1') {
          var urlRenameImage = Uri.parse(baseUrl1 + '/api/yolov5/rename_img');
          var renameImage = await http.get(urlRenameImage);

          if (renameImage == '1') {
            var urlYolo = Uri.parse(baseUrl1 + '/api/yolov5');
            var yolo = await http.get(urlYolo);

            if (yolo == '1') {
              var urlConfidence =
                  Uri.parse(baseUrl1 + '/api/yolov5/confidence');
              var confidence = await http.get(urlConfidence);

              if (confidence == '1') {
                res = 'Garbage detected';
              } else {
                res = 'Something went wrong';
              }
            }
          } else {
            res = 'Something went wrong';
          }
        } else {
          res = 'Something went wrong';
        }
      } else {
        res = 'Something went wrong';
      }

      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      if (res == 'Garbage detected') {
        await _firebaseDatabase.ref().child("complaints").push().set(data);
        return 'Registered!';
      }
      return 'Not Registered';
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

  Future<String> removeComplaint(String complaintId) async {
    try {
      print('Complaint ID: ' + complaintId);
      await _firebaseDatabase.ref('complaints').child(complaintId).remove();
      return 'Removed!';
    } catch (e) {
      print('Error: $e');
      return 'Error';
    }
  }

  Future<String> getUserType(String userId) async {
    try {
      dynamic usertype =
          await _firebaseDatabase.ref('users').child(userId).get();

      print('user type ' + usertype.value['userType'].toString());
      return usertype.value['userType'].toString();
    } catch (e) {
      print('Error: $e');
      return 'Error';
    }
  }

  Future<String> editComplaint(
      String complaintId, dynamic complain, String status) async {
    try {
      print('Complaint ID: in privder' + complaintId);
      await _firebaseDatabase
          .ref('complaints')
          .child(complaintId)
          .update({'status': status});
      return 'updated!';
    } catch (e) {
      print('Error: $e');
      return 'Error';
    }
  }

  Future<String> editFaq(String faqId, String faq) async {
    try {
      print('Complaint ID: ' + faqId);
      await _firebaseDatabase.ref('faq').child(faqId).set({
        'answer': faq,
      });
      return 'updated!';
    } catch (e) {
      print('Error: $e');
      return 'Error';
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

  Future<Map<String, int>> getComplaintsPercentage() async {
    try {
      List<dynamic> complaintsList = await getAllComplaint();
      int total_count = complaintsList.length;
      int registeredComplaintsCount = 0;
      int canceledComplaintsCount = 0;
      int completedComplaintsCount = 0;
      Map<String, int> percentageMap = {};
      List<dynamic> filteredList = [];
      final userId = await getUserId();
      for (var complaint in complaintsList) {
        if (complaint['status'] == 'completed') {
          completedComplaintsCount++;
        } else if (complaint['status'] == 'Canceled') {
          canceledComplaintsCount++;
        } else {
          //This is the case for registered Complaints
          registeredComplaintsCount++;
        }
      }
      print('==================================================');
      print('completedComplaintsCount: ' + completedComplaintsCount.toString());
      print('canceledComplaintsCount: ' + canceledComplaintsCount.toString());
      print(
          'registeredComplaintsCount: ' + registeredComplaintsCount.toString());
      return percentageMap;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  double distance(double lat1, double long1, double lat2, double long2) {
    // Convert the latitudes
    // and longitudes
    // from degree to radians.
    lat1 = vectorMath.radians(lat1);
    long1 = vectorMath.radians(long1);
    lat2 = vectorMath.radians(lat2);
    long2 = vectorMath.radians(long2);

    // Haversine Formula
    double dlong = long2 - long1;
    double dlat = lat2 - lat1;

    double ans = math.pow(math.sin(dlat / 2), 2) +
        math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dlong / 2), 2);

    ans = 2 * math.asin(math.sqrt(ans));

    // Radius of Earth in
    // Kilometers, R = 6371
    // Use R = 3956 for miles
    //double R = 6371;
    double R = (1.56786 * math.pow(math.e, -7));

    // Calculate the result in meters
    ans = ans * R;

    return ans;
  }

  int minutesBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute);
    print('from:' + from.toString());
    print('to:' + to.toString());
    return (from.difference(to).inMinutes).round();
  }
}
