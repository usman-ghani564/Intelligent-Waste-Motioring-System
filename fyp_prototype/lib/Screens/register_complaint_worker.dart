import 'dart:io';

import 'package:flutter/material.dart';
import 'registration_detail_widget_worker.dart';
import 'package:image_picker/image_picker.dart';

class WorkerRegisterComplaint extends StatefulWidget {
  Function signout = () {};
  Function getuserid = () {};
  dynamic complain2;
  String key2='';
  WorkerRegisterComplaint(Function sout, Function getuid,dynamic complain,String key) {
    signout = sout;
    getuserid = getuid;
    complain2 = complain;
    key2 = key;

  }

  @override
  _WorkerRegisterComplaintState createState() => _WorkerRegisterComplaintState();
}

class _WorkerRegisterComplaintState extends State<WorkerRegisterComplaint> {
  File? _image;
  final imagePicker = ImagePicker();

  Future _getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    return _image == null
        ? Container()
        : RegistationDetailsWidget(_image!, widget.signout, widget.getuserid,widget.complain2,widget.key2);
  }
}
