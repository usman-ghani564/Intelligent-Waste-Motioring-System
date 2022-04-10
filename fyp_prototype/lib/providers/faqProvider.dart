import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

import 'package:firebase_database/firebase_database.dart';
import 'package:fyp_prototype/models/faq.dart';

class FaqProvider {
  final FirebaseDatabase _firebaseDatabase;


  FaqProvider(this._firebaseDatabase);

  Future<String> registerQuestion(FAQ faq ) async {
    try {
      var data = {
        'cid': faq.getCustomerId,
         'question':faq.getQuestion,
         'answer':faq.getAnswer
      };
      await _firebaseDatabase
          .ref()
          .child("faq")
          .push()
          .set(data)
          .then((value) async {
        print('successful');
      });
      return "Question Registered!";
    } catch (e) {
      print('Error: $e');
      return e.toString();
    }
  }


}
