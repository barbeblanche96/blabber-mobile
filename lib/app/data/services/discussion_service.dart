import 'dart:convert';

import 'package:get/get.dart';

import 'package:blabber_mobile/app/data/models/discussion.dart';
import 'package:blabber_mobile/app/getx_services/initialization_service.dart';

class DiscussionService {
  static DiscussionService? _instance;

  factory DiscussionService() => _instance ??= DiscussionService._();

  DiscussionService._();

  final api =  Get.find<InitializationService>().api;

  Future<Discussion> createDiscussion(data) async {
    var response = await api.post('discussions', data: jsonEncode(data));

    return Discussion.fromJson(response.data);
  }

  Future<List<Discussion>> fetchDiscussions(
      {Map<String, dynamic>? queryParameters}) async {
    var response = await api.get('discussions', queryParameters: queryParameters);


    return (response.data as List).map((x) => Discussion.fromJson(x))
        .toList();
  }

  Future<Discussion> getDiscussion(id) async {
    var response = await api.get('discussions/'+id);


    return Discussion.fromJson(response.data);
  }

  Future<Discussion> patchDiscussion(id, data) async {
    var response = await api.patch('discussions/'+id, data: jsonEncode(data));


    return Discussion.fromJson(response.data);
  }
}