import 'package:blabber_mobile/app/data/models/ChatMessageModel.dart';
import 'package:blabber_mobile/app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/chat_detail_controller.dart';

class ChatDetailView extends GetView<ChatDetailController> {

  ChatDetailView({Key? key}) : super(key: key);

  final _textController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Obx(() => Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                ),
                SizedBox(width: 2,),
                controller.discussionPhoto.value != null ? CircleAvatar(
                  backgroundImage: NetworkImage(Constants.BASE_URL+controller.discussionPhoto.value!),
                  maxRadius: 20,
                ) : CircleAvatar(
                  backgroundColor: Colors.pink,
                  child: Text(controller.discussionTitle.value[0].toUpperCase()+controller.discussionTitle.value[1].toUpperCase()),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(controller.discussionTitle.value,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                      Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                    ],
                  ),
                ),
                Icon(Icons.info,color: Colors.black54,),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: controller.messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            itemBuilder: (context, index){
              return Padding(
                padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 5),
                child: Align(
                  alignment: (controller.messages[index].senderId != controller.authUser.id ?Alignment.topLeft:Alignment.topRight),
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: 300
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (controller.messages[index].senderId != controller.authUser.id ?Colors.grey.shade200:Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(controller.messages[index].text ?? "New File", style: TextStyle(fontSize: 16),),
                        SizedBox(height: 10,),
                        Text(DateFormat("EEE dd MMM HH:mm").format(DateTime.fromMillisecondsSinceEpoch(controller.messages[index].createdAt!)), textAlign: TextAlign.right, style: TextStyle(fontSize: 13),)
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: () async{
                      await controller.createMessage(_textController.text);
                      _textController.text = "";
                    },
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.pink,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    ));
  }
}
