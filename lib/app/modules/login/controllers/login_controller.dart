import 'package:blabber_mobile/app/data/services/users_service.dart';
import 'package:blabber_mobile/app/getx_services/user_session_service.dart';
import 'package:blabber_mobile/app/routes/app_pages.dart';
import 'package:blabber_mobile/app/utils/user_session.dart';
import 'package:blabber_mobile/app/widgets/snackbar_sharing.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  final isLoading = false.obs;

  final obscurePassword = true.obs;
  
  final userService = UserService();
  final userSession = UserSession();
  final snackbar = SnackbarSharing();
  final userSessionService = Get.find<UserSessionService>();
  
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  
  Future<void> login (email, password) async {
    isLoading.value = true;
    try {
      final response = await userService.login({ 'email' : email, 'password' : password, 'strategy' : 'local' });
      await userSession.saveAfterLoginUser(response);
      await userSessionService.loadUserSession();
      isLoading.value = false;
      snackbar.successMsg("Login successfully completed");
      Get.offAllNamed(Routes.HOME);
    } catch(e) {
      print(e);
      isLoading.value = false;
    }
  }

}
