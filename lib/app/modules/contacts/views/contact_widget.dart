import 'package:blabber_mobile/app/data/models/contact.dart';
import 'package:blabber_mobile/app/getx_services/user_session_service.dart';
import 'package:blabber_mobile/app/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactWidget extends StatefulWidget {
  ContactWidget({Key? key, required this.contacts}) : super(key: key);

  final List<Contact> contacts;

  @override
  State<ContactWidget> createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {

  final authUser = Get.find<UserSessionService>().activeUserSession.value;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.contacts.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index){

        UserContact contactUser = UserContact();
        String userContactId = "";

        if (widget.contacts[index].userId1 != authUser.id) {
          contactUser = widget.contacts[index].user1!;
          userContactId = widget.contacts[index].userId1!;
        } else {
          contactUser = widget.contacts[index].user2!;
          userContactId = widget.contacts[index].userId2!;
        }

        return ContactItem(
          id : userContactId,
          lastname: contactUser.lastname!,
          firstname: contactUser.firstname!,
          imageUrl: contactUser.photoUrl,
          email: contactUser.email!
        );
      },
    );
  }
}
