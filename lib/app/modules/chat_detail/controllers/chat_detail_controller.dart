import 'package:blabber_mobile/app/data/models/discussion.dart';
import 'package:blabber_mobile/app/data/models/message.dart';
import 'package:blabber_mobile/app/data/services/discussion_service.dart';
import 'package:blabber_mobile/app/data/services/message_service.dart';
import 'package:blabber_mobile/app/getx_services/initialization_service.dart';
import 'package:blabber_mobile/app/getx_services/user_session_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ChatDetailController extends GetxController {
  //TODO: Implement ChatDetailController

  final retrieveData = Get.arguments;

  final isLoading = false.obs;
  final messages = <Message>[].obs;
  final discussion = Rx(Discussion());
  final discussionService = DiscussionService();
  final messageService = MessageService();
  final authUser = Get.find<UserSessionService>().activeUserSession.value;
  final discussionTitle = "Loading...".obs;
  final discussionPhoto = RxnString();
  final socket =  Get.find<InitializationService>().socket;

  @override
  void onInit() async{
    super.onInit();
    initializeDateFormatting();
    discussionTitle.value = retrieveData['name'];
    discussionPhoto.value = retrieveData['imageUrl'];
    if(retrieveData.containsKey('userId') && !retrieveData.containsKey('id')) {
      await checkDiscussion();
    } else {
     await getDiscussion();
    }
    fetchMessages();

    if(retrieveData.containsKey('id')) {
      openDiscussion();
    }

    socket.on('messages created', (data) {
      Message message = Message.fromJson(data);
      if (discussion.value.id == message.discussionId) {
        messages.add(message);
        messages.refresh();
      }
    });
  }

  List<dynamic> computeProperties (Discussion discussion) {
    //String date = DateFormat("EEE dd MMM HH:mm").format(DateTime.fromMillisecondsSinceEpoch(discussion.updatedAt!));
    if (discussion.tag == 'PRIVATE') {
      var contactUser = discussion.participants?.firstWhere((element) => element.userId != authUser.id);
      return ["${contactUser?.user!.firstname} ${contactUser?.user!.lastname}", contactUser?.user!.photoUrl];
    }
    return [discussion.name!, null];
  }

  Future<void> fetchMessages () async {
    isLoading.value = true;
    try {
      var query = {
        '\$paginate': false,
        '\$sort': {
          'updatedAt': 1
        },
        'discussionId': discussion.value.id
      };
      final response = await messageService.fetchMessages(queryParameters: query);
      messages.value = response;
      isLoading.value = false;
    } catch(e) {
      isLoading.value = false;
    }
  }

  Future<void> getDiscussion () async {
    try {
      final response = await discussionService.getDiscussion(retrieveData['id']);
      discussion.value = response;
      var propertiesValue = computeProperties(discussion.value);
      discussionTitle.value = propertiesValue[0];
      discussionPhoto.value = propertiesValue[1];
    } catch(e) {
      print(e);
    }
  }

  Future<void> checkDiscussion () async {
    try {
      var query = {
        "\$paginate" : false,
        "tag": "PRIVATE",
        "\$and": [
          {
            "participants.userId" :  authUser.id
          },
          {
            "participants.userId" :  retrieveData['userId']
          },
        ]
      };
      final response = await discussionService.fetchDiscussions(queryParameters: query);
      if (response.length > 0) {
        discussion.value = response[0];
      } else {
        await createDiscussion();
      }
      var propertiesValue = computeProperties(discussion.value);
      discussionTitle.value = propertiesValue[0];
      discussionPhoto.value = propertiesValue[1];
      discussion.refresh();
    } catch(e) {
      print(e);
    }
  }

  Future<void> createDiscussion () async {
    try {
      final response = await discussionService.createDiscussion({"userId" : retrieveData['userId'], "tag": "PRIVATE"});
      discussion.value = response;
    } catch(e) {
      print(e);
    }
  }

  Future<void> openDiscussion () async {
    try {
      final response = await discussionService.patchDiscussion(discussion.value.id, {"action" : "OPEN_DISCUSSION"});
      discussion.value = response;
    } catch(e) {
      print(e);
    }
  }

  Future<void> createMessage (text) async {
    try {
      final response = await messageService.createMessage({"text" : text, "discussionId": discussion.value.id});
      print(response);
    } catch(e) {
      print(e);
    }
  }
}
