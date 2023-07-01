import 'package:blabber_mobile/app/widgets/snackbar_sharing.dart';
import 'package:flutter/material.dart';
import 'package:blabber_mobile/app/data/models/discussion.dart';
import 'package:blabber_mobile/app/getx_services/initialization_service.dart';
import 'package:blabber_mobile/app/getx_services/user_session_service.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SocketService extends GetxService {

  final socket =  Get.find<InitializationService>().socket;
  final userSessionService = Get.find<UserSessionService>();
  final initService = Get.find<InitializationService>();
  final snackbar = SnackbarSharing();


  Future<SocketService> init() async {

    final isLogged = userSessionService.isLogin();

    if (isLogged) {
      socket.emitWithAck('create', [
        'authentication',
        {
          'strategy': 'jwt',
          'accessToken': userSessionService.activeUserSession.value.authToken
        }
      ], ack: (data) {
        if (data != null) {
          print('socket connected');
        } else {
          print("Null") ;
        }
      });

      socket.on('discussions created', (data) {
        Discussion discussion = Discussion.fromJson(data);
        if(discussion.name != null) {
          snackbar.successMsg("You were add to a new discussion "+discussion.name!);
        } else {
          Participant? contact = discussion.participants?.firstWhere((element) => element.userId != userSessionService.activeUserSession.value.id);
          if(contact != null) {
            snackbar.successMsg("${contact.user!.firstname} ${contact.user!.lastname} try to initiate discussion with you");
          }
        }
      });

      socket.on('discussions patched', (data) {
        Discussion discussion = Discussion.fromJson(data);
        Participant? me = discussion.participants?.firstWhere((element) => element.userId == userSessionService.activeUserSession.value.id);

        if (me != null && me.hasNewNotif!) {
          if(discussion.name != null) {
            snackbar.successMsg("You received new message from discussion group "+discussion.name!);
          } else {
            Participant? contact = discussion.participants?.firstWhere((element) => element.userId != userSessionService.activeUserSession.value.id);
            if(contact != null) {
              snackbar.successMsg("You received new private message from ${contact.user!.firstname} ${contact.user!.lastname}");
            }
          }
        }
        print(discussion.name);
      });
    }

    return this;
  }

}