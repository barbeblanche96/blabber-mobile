import 'package:blabber_mobile/app/getx_services/initialization_service.dart';
import 'package:blabber_mobile/app/getx_services/user_session_service.dart';
import 'package:blabber_mobile/app/routes/app_pages.dart';
import 'package:blabber_mobile/app/widgets/snackbar_sharing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomMenu extends StatefulWidget {
  BottomMenu({Key? key}) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {

  final initService = Get.find<InitializationService>();
  final userSessionService = Get.find<UserSessionService>();
  final snackbar = SnackbarSharing();
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: initService.selectedMenu.value,
      selectedItemColor: Colors.red,
      onTap: (int index) async {
        if (index == 0) {
          initService.setSelectedMenu(0);
          Get.offAllNamed(Routes.HOME);
        }
        else if (index == 1) {
          initService.setSelectedMenu(1);
          Get.offAllNamed(Routes.CONTACTS);
        }
        else if (index == 2) {
          initService.setSelectedMenu(2);
          Get.offAllNamed(Routes.CONTACTS);
        }
        else if (index == 3) {
          initService.setSelectedMenu(0);
          await userSessionService.clearSession();
          snackbar.successMsg("Logout successful");
          Get.offAllNamed(Routes.LOGIN);
        }
      },
      unselectedItemColor: Colors.grey.shade600,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: "Chats",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group_work),
          label: "Contacts",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: "Profile",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: "Logout",
        ),
      ],
    );
  }
}
