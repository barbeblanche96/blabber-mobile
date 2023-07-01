import 'package:blabber_mobile/app/getx_services/initialization_service.dart';
import 'package:blabber_mobile/app/getx_services/socket_service.dart';
import 'package:blabber_mobile/app/getx_services/user_session_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> initServices () async {
  await Get.putAsync(() => InitializationService().init());
  await Get.putAsync(() => UserSessionService().init());
  await Get.putAsync(() => SocketService().init());
  print("All services started");
}



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  final userSessionService = Get.find<UserSessionService>();
  final isLogged = userSessionService.isLogin();
  runApp(
    GetMaterialApp(
      title: "Application",
      theme: ThemeData(fontFamily: 'RobotoMono'),
      initialRoute: isLogged ? AppPages.INITIAL : Routes.LOGIN,
      getPages: AppPages.routes,
    ),
  );
}
