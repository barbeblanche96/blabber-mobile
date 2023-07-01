import 'package:blabber_mobile/app/data/models/auth_user.dart';
import 'package:blabber_mobile/app/getx_services/initialization_service.dart';
import 'package:blabber_mobile/app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {

  final SharedPreferences prefs = Get.find<InitializationService>().prefs;

  String getToken() {
    return prefs.getString(Constants.PREF_KEY_USER_JWT) ?? '';
  }

  Future<bool> setToken(String token) async {
    return await prefs.setString(Constants.PREF_KEY_USER_JWT, token);
  }

  String getID() {
    return prefs.getString(Constants.PREF_KEY_USER_ID) ?? '';
  }

  Future<bool> setID(String id) async {
    return await prefs.setString(Constants.PREF_KEY_USER_ID, id);
  }

  String getEmail() {
    return prefs.getString(Constants.PREF_KEY_USER_EMAIL) ?? '';
  }

  Future<bool> setEmail(String email) async {
    return await prefs.setString(Constants.PREF_KEY_USER_EMAIL, email);
  }

  String getPhotoUrl() {
    return prefs.getString(Constants.PREF_KEY_USER_PHOTO) ?? '';
  }

  Future<bool> setPhotoUrl(String photo) async {
    return await prefs.setString(Constants.PREF_KEY_USER_PHOTO, photo);
  }

  String getLastname() {
    return prefs.getString(Constants.PREF_KEY_USER_LASTNAME) ?? '';
  }

  Future<bool> setLastname(String lastname) async {
    return await prefs.setString(Constants.PREF_KEY_USER_LASTNAME, lastname);
  }

  String getFirstname() {
    return prefs.getString(Constants.PREF_KEY_USER_FIRSTNAME) ?? '';
  }

  Future<bool> setFirstname(String firstname) async {
    return await prefs.setString(Constants.PREF_KEY_USER_FIRSTNAME, firstname);
  }

  String getUsername() {
    return prefs.getString(Constants.PREF_KEY_USER_USERNAME) ?? '';
  }

  Future<bool> setUsername(String username) async {
    return await prefs.setString(Constants.PREF_KEY_USER_USERNAME, username);
  }

  removeUser() async {
    await prefs.clear();
  }

  saveAfterLoginUser(AuthUser user) async {
    await setLastname(user.user!.lastname!);
    await setFirstname(user.user!.firstname!);
    await setEmail(user.user!.email!);
    await setToken(user.accessToken!);
    await setID(user.user!.id!);
    await setUsername(user.user!.username!);
    user.user?.photoUrl != null ? await setPhotoUrl(user.user!.photoUrl!) : null;
  }
}