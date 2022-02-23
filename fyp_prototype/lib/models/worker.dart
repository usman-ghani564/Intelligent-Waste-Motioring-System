import 'package:fyp_prototype/models/person.dart';

class Worker extends Person {
  String workerId = "";
  String status = "";
  String role = "";
  get getWorkerId => workerId;

  set setWorkerId(workerId) => this.workerId = workerId;

  get getStatus => status;

  set setStatus(status) => this.status = status;

  get getRole => role;

  set setRole(role) => this.role = role;
}
