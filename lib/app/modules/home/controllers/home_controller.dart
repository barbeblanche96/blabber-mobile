import 'package:blabber_mobile/app/data/models/discussion.dart';
import 'package:blabber_mobile/app/data/services/discussion_service.dart';
import 'package:blabber_mobile/app/getx_services/initialization_service.dart';
import 'package:blabber_mobile/app/getx_services/user_session_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final discussions = <Discussion>[].obs;
  final isLoading = false.obs;
  final discussionService = DiscussionService();
  final authUser = Get.find<UserSessionService>().activeUserSession.value;
  final socket =  Get.find<InitializationService>().socket;

  Future<void> fetchDiscussions () async {
    isLoading.value = true;
    try {
      var query = {
        '\$paginate': false,
        '\$sort': {
          'updatedAt': -1
        },
        'participants' : {
          "\$elemMatch" : {
            "userId" : authUser.id,
            "isArchivedChat": false
          }
        }
      };
      final response = await discussionService.fetchDiscussions(queryParameters: query);
      discussions.value = response;
      isLoading.value = false;
    } catch(e) {
      print(e);
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchDiscussions();

    socket.on('discussions created', (data) {
      Discussion discussion = Discussion.fromJson(data);
      discussions.add(discussion);
      discussions.sort((a, b) => (b.updatedAt!).compareTo(a.updatedAt!));
      discussions.refresh();
    });

    socket.on('discussions patched', (data) {
      Discussion discussion = Discussion.fromJson(data);
      int index = discussions.indexWhere((item) => item.id == discussion.id);
      if(index > 0) {
        discussions[index] = discussion;
        discussions.sort((a, b) => (b.updatedAt!).compareTo(a.updatedAt!));
        discussions.refresh();
      }
    });
  }
}
