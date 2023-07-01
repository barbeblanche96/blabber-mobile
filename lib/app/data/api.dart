import 'package:blabber_mobile/app/utils/constants.dart';
import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Api {
  final tokenDio = Dio(BaseOptions(baseUrl: Constants.BASE_URL));
  final api = createDio();
  final IO.Socket socketIO = IO.io(Constants.BASE_URL, {
    'transports': ['websocket'],
    'autoConnect': true, // Socketio will reconnect automatically when connection is lost
  });

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Constants.BASE_URL,
      receiveTimeout: Duration(seconds: 30), // 15 seconds
      connectTimeout: Duration(seconds: 30),
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }




}

class AppInterceptors extends Interceptor {

  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString(Constants.PREF_KEY_USER_JWT) ?? '';

    if (accessToken != "") {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        Get.snackbar('Error', 'Connection timeout', colorText: Colors.red, backgroundColor: Colors.white);
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.sendTimeout:
        Get.snackbar('Error', 'Connection timeout', colorText: Colors.red, backgroundColor: Colors.white);
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.receiveTimeout:
        Get.snackbar('Error', 'Connection timeout', colorText: Colors.red, backgroundColor: Colors.white);
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            displayFormatErrorMessage(err.response!.data);
            throw BadRequestException(err.requestOptions);
          case 401:
            //logout();
            displayFormatErrorMessage(err.response!.data);
            throw UnauthorizedException(err.requestOptions);
          case 404:
            displayFormatErrorMessage(err.response!.data);
            throw NotFoundException(err.requestOptions);
          case 409:
            displayFormatErrorMessage(err.response!.data);
            throw ConflictException(err.requestOptions);
          case 422:
            displayFormatErrorMessage(err.response!.data);
            throw ProcessEntityException(err.requestOptions);
          case 500:
            Get.snackbar('Error', 'Internal server error', colorText: Colors.red, backgroundColor: Colors.white);
            print(err.response!.data);
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        Get.snackbar('Error', 'Check your Internet connection and try again', colorText: Colors.red, backgroundColor: Colors.white);
        throw NoInternetConnectionException(err.requestOptions);
      default:
        Get.snackbar('Error', 'An error occured retry later', colorText: Colors.red, backgroundColor: Colors.white);
        break;
    }

    return handler.next(err);
  }

  Future<void> logout () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAllNamed('/login');
  }

  void displayFormatErrorMessage (error) {
    print(error);
    if (error is String) {
      Get.snackbar('Erreur', error, colorText: Colors.red, backgroundColor: Colors.white);
    }
    else if (error is List) {
      String toDisplay = "";
      for(final e in error){
        var currentElement = e['message'];
        toDisplay = toDisplay+currentElement+"\n";
      }
      Get.snackbar('Erreur', toDisplay, colorText: Colors.red, backgroundColor: Colors.white);
    }
    else {
      var mapValue = Map<String, dynamic>.from(error);
      if (mapValue.containsKey('data')) {
        if(mapValue['data'] is String) {
          Get.snackbar('Error', mapValue['data'], colorText: Colors.red, backgroundColor: Colors.white);
        } else if (mapValue['data'] is List) {
          String toDisplay = "";
          for( var v in mapValue['data']) {
            var currentElement = v['message'];
            toDisplay = toDisplay+currentElement+"\n";
          }
          Get.snackbar('Error', toDisplay, colorText: Colors.red, backgroundColor: Colors.white);
        }
        else {
          String toDisplay = "";
          mapValue['data'].forEach((k,v) {
            var currentElement = "${k} : ${v['message']}";
            toDisplay = toDisplay+currentElement+"\n";
          });
          Get.snackbar('Error', toDisplay, colorText: Colors.red, backgroundColor: Colors.white);
        }
      } else if (mapValue.containsKey('message')) {
        if (mapValue['message'] is String) {
          Get.snackbar('Error', mapValue['message'], colorText: Colors.red, backgroundColor: Colors.white);
        }
      } else {
        Get.snackbar('Error', "An error has occurred, please try again later", colorText: Colors.red, backgroundColor: Colors.white);
      }
    }
  }

}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ProcessEntityException extends DioError {
  ProcessEntityException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Process Entity exception occurred';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}