import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_prototype/widgets/registration_details_widget.dart';
import 'package:image_picker/image_picker.dart';

class RegisterComplaint extends StatefulWidget {
  Function signout = () {};
  RegisterComplaint(Function sout) {
    signout = sout;
  }

  @override
  _RegisterComplaintState createState() => _RegisterComplaintState();
}

class _RegisterComplaintState extends State<RegisterComplaint> {
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
        : RegistationDetailsWidget(_image!, widget.signout);
  }
}
