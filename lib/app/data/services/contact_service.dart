import 'package:blabber_mobile/app/data/models/contact.dart';
import 'package:get/get.dart';

import 'package:blabber_mobile/app/getx_services/initialization_service.dart';

class ContactService {
  static ContactService? _instance;

  factory ContactService() => _instance ??= ContactService._();

  ContactService._();

  final api =  Get.find<InitializationService>().api;

  Future<List<Contact>> fetchContacts(
      {Map<String, dynamic>? queryParameters}) async {
    var response = await api.get('contacts', queryParameters: queryParameters);


    return (response.data as List).map((x) => Contact.fromJson(x))
        .toList();
  }

  Future<Contact> getContact(id) async {
    var response = await api.get('contacts/'+id);

    return Contact.fromJson(response.data);
  }
}