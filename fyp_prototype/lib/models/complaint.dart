import 'dart:core';

import 'dart:io';

class Complaint {
  String _userId = "";
  String _status = "";
  double _latitude = 0.0;
  double _longitude = 0.0;
  DateTime _dateTime = DateTime.now();
  String _imageUrl = '';
  late File _imageFile;

  Complaint({userid = "", stat = "", lat = 0.0, long = 0.0, dateT, imgFile}) {
    _userId = userid;
    _status = stat;
    _latitude = lat;
    _longitude = long;
    _dateTime = dateT;
    _imageFile = imgFile;
  }

  String get getUserId => _userId;

  set setUserId(String userId) => _userId = userId;

  get getStatus => _status;

  set setStatus(status) => _status = status;

  get getLatitude => _latitude;

  set setLatitude(latitude) => _latitude = latitude;

  get getLongitude => _longitude;

  set setLongitude(longitude) => _longitude = longitude;

  get getDateTime => _dateTime;

  set setDateTime(dateTime) => _dateTime = dateTime;

  String get getImageUrl => _imageUrl;

  set setImageUrl(String imageUrl) => _imageUrl = imageUrl;

  get imageFile => _imageFile;

  set imageFile(value) => _imageFile = value;
}
