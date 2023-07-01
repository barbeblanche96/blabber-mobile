import 'package:blabber_mobile/app/modules/home/views/chat_widget.dart';
import 'package:blabber_mobile/app/routes/app_pages.dart';
import 'package:blabber_mobile/app/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: controller.isLoading.value ?
      Center(child: CircularProgressIndicator(color: Colors.pink,),) :
      controller.discussions.length > 0 ?
      Column(
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
                      Text("Conversations",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
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
                            Text("New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
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
          Expanded(child: SingleChildScrollView(child: ChatWidget(chats: controller.discussions,))),
        ],
      ) :
      Center(child: Text("No discussions", style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),)),
      bottomNavigationBar: BottomMenu(),
    ));
  }
}
