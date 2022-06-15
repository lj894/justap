import 'package:get/state_manager.dart';
import 'package:justap/models/user.dart';
import 'package:justap/services/remote_services.dart';

class ROUserController extends GetxController {
  var isLoading = true.obs;
  var user = SiteUser().obs;

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  void fetchUser() async {
    try {
      isLoading(true);
      var u = await RemoteServices.fetchUserByCode();
      if (u != null) {
        user.update((user) {
          user?.nickName = u.nickName;
          user?.introduction = u.introduction;
          user?.email = u.email;
          user?.profileUrl = u.profileUrl;
          user?.backgroundUrl = u.backgroundUrl;
          user?.code = u.code;
          user?.owner = u.owner;
        });
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
