import 'package:fyp_prototype/models/person.dart';

class FAQ {
  String CustomerId = "";
  String Question = "";
  String Answer = "";

  String get getCustomerId => CustomerId;
  String get getQuestion => Question;
  String get getAnswer => Answer;

  void setQuestion(String Question) {
    this.Question=Question;
  }
  void setAnswer(String Answer) {
    this.Answer=Answer;
  }
  void setCustomerId(String CID) {
    this.CustomerId=CID;
  }
}
