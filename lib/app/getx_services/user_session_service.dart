import 'package:blabber_mobile/app/getx_services/initialization_service.dart';
import 'package:get/get.dart';
import 'package:blabber_mobile/app/utils/user_session.dart';

class UserSessionService extends GetxService {

  final activeUserSession = ActiveUserSession().obs;
  final userSession = UserSession();
  final api =  Get.find<InitializationService>().api;

  Future<UserSessionService> init() async {
    await loadUserSession();
    return this;
  }

  Future<void> loadUserSession () async {
    activeUserSession.value.id = userSession.getID();
    activeUserSession.value.authToken = userSession.getToken();
    activeUserSession.value.firstname = userSession.getFirstname();
    activeUserSession.value.lastname = userSession.getLastname();
    activeUserSession.value.email = userSession.getEmail();
    activeUserSession.value.username = userSession.getUsername();
    activeUserSession.refresh();
  }

  bool isLogin() {
    if(activeUserSession.value.authToken != null && activeUserSession.value.authToken != "") {
      return true;
    }
    return false;
  }

  Future<void> clearSession() async{
    await userSession.removeUser();
    activeUserSession.value = ActiveUserSession();
    activeUserSession.refresh();
  }

}

class ActiveUserSession {
  String? id;
  String? authToken;
  String? firstname;
  String? lastname;
  String? photoUrl;
  String? username;
  String? email;

  ActiveUserSession({
    this.id,
    this.authToken,
    this.firstname,
    this.lastname,
    this.email,
    this.username,
    this.photoUrl,
  });

}