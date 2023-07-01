import 'package:blabber_mobile/app/data/models/contact.dart';
import 'package:blabber_mobile/app/data/services/contact_service.dart';
import 'package:blabber_mobile/app/getx_services/user_session_service.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  //TODO: Implement ContactsController

  final isLoading = false.obs;
  final contacts = <Contact>[].obs;
  final contactService = ContactService();
  final authUser = Get.find<UserSessionService>().activeUserSession.value;
  List<Contact> contactsCopy = [];

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  void searchContacts (String? searchText) {

    contacts.value = List.from(contactsCopy);

    if(searchText != null && searchText.length > 2) {
      List<Contact> filteredContacts = contacts.value.where((element) =>
      element.user1!.firstname!.toLowerCase().contains(searchText.toLowerCase()) ||
          element.user1!.lastname!.toLowerCase().contains(searchText.toLowerCase()) ||
          element.user2!.firstname!.toLowerCase().contains(searchText.toLowerCase()) ||
          element.user2!.lastname!.toLowerCase().contains(searchText.toLowerCase())).toList();
      contacts.value = filteredContacts;
      contacts.refresh();
    }
  }

  Future<void> fetchContacts () async {
    isLoading.value = true;
    try {
      var query = {
        '\$paginate': false
      };
      final response = await contactService.fetchContacts(queryParameters: query);
      contacts.value = response;
      contactsCopy = List.from(contacts);
      isLoading.value = false;
    } catch(e) {
      print(e);
      isLoading.value = false;
    }
  }
}
