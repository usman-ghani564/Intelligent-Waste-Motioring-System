import 'package:fyp_prototype/models/person.dart';

class User extends Person {
  //TODO: String customerId = ""; Not Sure about this
  String userId = "";
  String status = "";

  String get getUserId => userId;
  set setUserId(String userId) => this.userId = userId;
  String get getStatus => status;
  set setStatus(String status) => this.status = status;
}
