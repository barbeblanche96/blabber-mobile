import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarSharing {
  successMsg (String msg) {
    Get.snackbar('Success', msg, colorText: Colors.green, backgroundColor: Colors.white);
  }
  errorMsg (String msg) {
    Get.snackbar('Error', msg, colorText: Colors.red, backgroundColor: Colors.white);
  }
}
