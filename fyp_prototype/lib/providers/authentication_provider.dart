import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthenticationProvider {
  final FirebaseAuth _firebaseAuthInstance;
  final FirebaseDatabase _firebaseDatabase;

  AuthenticationProvider(this._firebaseAuthInstance, this._firebaseDatabase);

  Future<String> signin(
      {String email = "", String password = "", String userType = ""}) async {
    String returnString = "";
    try {
      await _firebaseAuthInstance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        DatabaseReference ref = _firebaseDatabase.ref("users/");
        bool isDesiredUser = false;
        // Get the data once{
        await ref.once().then((snap) {
          Map<dynamic, dynamic> map =
              snap.snapshot.value as Map<dynamic, dynamic>;
          // 👇 Loop over the post keys and post values
          map.forEach((key, value) {
            if (value['email'].toString().compareTo(email) == 0) {
              if (value['userType'] == userType) isDesiredUser = true;
            }
          });
        }).then((value) {
          if (!isDesiredUser) {
            _firebaseAuthInstance.signOut();
            returnString = 'Wrong Credentials!';
          }
        });
      });
      if (returnString != 'Wrong Credentials!') returnString = "Signed In";
      return returnString;
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> signUp(
      {String email = "", String password = "", String userType = ""}) async {
    try {
      await _firebaseAuthInstance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        var data = {
          'uid': user.user!.uid,
          'email': email,
          'password': password,
          'userType': userType,
        };
        _firebaseDatabase.ref().child("users").child(user.user!.uid).set(data);
      });
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuthInstance.signOut();
      return "Signed Out";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }
}
