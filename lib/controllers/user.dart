import 'package:get/state_manager.dart';
import 'package:justap/models/user.dart';
import 'package:justap/services/remote_services.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var user = SiteUser().obs;

  @override
  void onInit() {
    //print(user().owner);
    fetchUser();
    super.onInit();
  }

  void fetchUser() async {
    try {
      isLoading(true);
      var u = await RemoteServices.fetchUser();
      if (u != null) {
        user.update((user) {
          user?.nickName = u.nickName;
          user?.introduction = u.introduction;
          user?.email = u.email;
          user?.profileUrl = u.profileUrl;
          user?.owner = u.owner;
        });
      }
    } finally {
      isLoading(false);
    }
  }
}
