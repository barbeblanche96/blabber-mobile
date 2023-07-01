import 'package:blabber_mobile/app/data/api.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitializationService extends GetxService {

  final api = Api().api;
  final socket = Api().socketIO;
  late SharedPreferences prefs;
  final selectedMenu = 0.obs;

  Future<InitializationService> init() async {

    prefs = await SharedPreferences.getInstance();

    return this;
  }

  void setSelectedMenu (int i) {
    selectedMenu.value = i;
    selectedMenu.refresh();
  }

}