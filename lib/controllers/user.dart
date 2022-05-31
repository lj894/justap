import 'package:get/state_manager.dart';
import 'package:justap/models/user.dart';
import 'package:justap/services/remote_services.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var user = <SiteUser>{}.obs;

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  void fetchUser() async {
    print('fetchUser');
    try {
      isLoading(true);
      var u = await RemoteServices.fetchUser();
      if (u != null) {
        print("user:");
        print(u);

        user = u as RxSet<SiteUser>;
        print(user);
      }
    } finally {
      print('user ends');
      isLoading(false);
    }
  }
}
