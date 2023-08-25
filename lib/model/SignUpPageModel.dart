import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPageModel extends GetxController {
  Rx<bool> studentcheck = Rx<bool>(false);
  Rx<bool> employeecheck = Rx<bool>(false);
  TextEditingController idPersonField = TextEditingController();

  studentupdatevalue(bool value) {
    studentcheck.value = value;
    update();
  }

  employeeupdatevalue(bool value) {
    employeecheck.value = value;
    update();
  }
}
