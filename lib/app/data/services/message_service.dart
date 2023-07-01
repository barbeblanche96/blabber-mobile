import 'dart:convert';

import 'package:blabber_mobile/app/data/models/message.dart';
import 'package:get/get.dart';

import 'package:blabber_mobile/app/getx_services/initialization_service.dart';

class MessageService {
  static MessageService? _instance;

  factory MessageService() => _instance ??= MessageService._();

  MessageService._();

  final api =  Get.find<InitializationService>().api;

  Future<List<Message>> fetchMessages(
      {Map<String, dynamic>? queryParameters}) async {
    var response = await api.get('messages', queryParameters: queryParameters);

    return (response.data as List).map((x) => Message.fromJson(x))
        .toList();
  }

  Future<Message> createMessage(data) async {
    var response = await api.post('messages', data: jsonEncode(data));

    return Message.fromJson(response.data);
  }
}