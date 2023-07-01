import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:blabber_mobile/app/data/models/discussion.dart';
import 'package:blabber_mobile/app/getx_services/user_session_service.dart';
import 'package:blabber_mobile/app/widgets/conversation_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({Key? key, required this.chats}) : super(key: key);

  final List<Discussion>chats;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
  }

  final authUser = Get.find<UserSessionService>().activeUserSession.value;

   List<dynamic> computeProperties (Discussion discussion) {
     var me = discussion.participants?.firstWhere((element) => element.userId == authUser.id);
     String date = DateFormat("EEE dd MMM HH:mm").format(DateTime.fromMillisecondsSinceEpoch(discussion.updatedAt!));
     String lastMessage = "";
     if(discussion.lastMessage == null) {
       var discussionCreator = discussion.participants?.firstWhere((element) => element.userId == discussion.createdById);
       lastMessage = "${discussionCreator?.user!.firstname} ${discussionCreator?.user!.lastname} want to initiate new discussion";
     } else {
       lastMessage = discussion.lastMessage?.text ?? 'New file (${discussion.lastMessage!.file!.originalName})';
     }
     if (discussion.tag == 'PRIVATE') {
        var contactUser = discussion.participants?.firstWhere((element) => element.userId != authUser.id);
        return ["${contactUser?.user!.firstname} ${contactUser?.user!.lastname}", contactUser?.user!.photoUrl, me!.hasNewNotif!, date, lastMessage];
     }

     return [discussion.name!, null, me!.hasNewNotif!, date, lastMessage];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.chats.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index){
        var valueProperties = computeProperties(widget.chats[index]);
        return ConversationItem(
          id: widget.chats[index].id!,
          name: valueProperties[0],
          messageText: valueProperties[4],
          imageUrl: valueProperties[1],
          time: valueProperties[3],
          isMessageRead: valueProperties[2],
        );
      },
    );
  }
}
