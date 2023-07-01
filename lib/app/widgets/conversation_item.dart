import 'package:blabber_mobile/app/routes/app_pages.dart';
import 'package:blabber_mobile/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationItem extends StatefulWidget{
  final String name;
  final String id;
  final String messageText;
  final String? imageUrl;
  final String time;
  final bool isMessageRead;
  ConversationItem({super.key, required this.name, required this.messageText, required this.imageUrl, required this.time, required this.isMessageRead, required this.id});
  @override
  _ConversationItemState createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.CHAT_DETAIL, arguments: {'id' : widget.id, 'name': widget.name, 'imageUrl': widget.imageUrl});
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  widget.imageUrl != null ? CircleAvatar(
                    backgroundImage: NetworkImage(Constants.BASE_URL+widget.imageUrl!),
                    maxRadius: 30,
                  ) : CircleAvatar(
                    backgroundColor: Colors.pink,
                    child: Text(widget.name[0].toUpperCase()+widget.name[1].toUpperCase(), style: TextStyle(fontSize: 25),),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.messageText, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 7 ,),
            Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}