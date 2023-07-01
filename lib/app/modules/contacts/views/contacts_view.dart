import 'package:blabber_mobile/app/modules/contacts/views/contact_widget.dart';
import 'package:blabber_mobile/app/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/contacts_controller.dart';

class ContactsView extends GetView<ContactsController> {
  const ContactsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Contacts",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                      Container(
                        padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.pink[50],
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add,color: Colors.pink,size: 20,),
                            SizedBox(width: 2,),
                            Text("Add",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                child: TextField(
                  onChanged: (String? value) {
                      controller.searchContacts(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.grey.shade100
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: SingleChildScrollView(child: ContactWidget(contacts: controller.contacts.value)))
        ],
      ),
      bottomNavigationBar: BottomMenu(),
    ));
  }
}
