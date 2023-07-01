import 'dart:convert';
import 'dart:io';

import 'package:blabber_mobile/app/data/models/auth_user.dart';
import 'package:blabber_mobile/app/getx_services/initialization_service.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';

import '../models/user.dart';

class UserService {
  static UserService? _instance;

  factory UserService() => _instance ??= UserService._();

  UserService._();

  final api =  Get.find<InitializationService>().api;

  static const String serviceName = 'users';

  Future<AuthUser> login(data) async {
    var response = await api.post('authentication', data: jsonEncode(data));

    return AuthUser.fromJson(response.data);
  }

  Future<User> register(data) async {
    var response = await api.post('users', data: jsonEncode(data));

    return User.fromJson(response.data);
  }


  Future<User> me(data) async {
    var response = await api.post('authentication', data: jsonEncode(data));

    return User.fromJson(response.data);
  }


  Future<User> update(id, data) async {
    var response = await api.patch('users/${id}', data: jsonEncode(data));

    return User.fromJson(response.data);
  }

  Future<dynamic> uploadImage(String userId, File file) async {
    String fileName = file.path.split('/').last;
    Dio.FormData formData = Dio.FormData.fromMap({
      "files": await Dio.MultipartFile.fromFile(file.path, filename:fileName),
      "action" : "PHOTO_PROFILE",
      "userId" : userId
    });
    //var response = await api.post("uploads", data: formData);

    return null;
  }
}