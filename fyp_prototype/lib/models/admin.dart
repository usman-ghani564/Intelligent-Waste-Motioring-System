import 'package:fyp_prototype/models/person.dart';

class Admin extends Person {
  String adminId = "";
  String status = "";
  String role = "";
  get getAdminId => adminId;

  set setAdminId(adminId) => this.adminId = adminId;

  get getStatus => status;

  set setStatus(status) => this.status = status;

  get getRole => role;

  set setRole(role) => this.role = role;
}
