import 'package:blabber_mobile/app/data/services/users_service.dart';
import 'package:blabber_mobile/app/routes/app_pages.dart';
import 'package:blabber_mobile/app/widgets/snackbar_sharing.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final obscurePassword = true.obs;
  final isLoading = false.obs;
  final userService = UserService();
  final snackbar = SnackbarSharing();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> register (email, password, firstname, lastname, username) async {
    isLoading.value = true;
    try {
      await userService.register({ 'email' : email, 'password' : password, 'firstname' : firstname, 'lastname': lastname, 'username': username });
      isLoading.value = false;
      snackbar.successMsg("Register successfully completed");
      Get.offAllNamed(Routes.LOGIN);
    } catch(e) {
      print(e);
      isLoading.value = false;
    }
  }

}
