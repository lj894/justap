import 'package:get/state_manager.dart';
import 'package:justap/models/media.dart';
import 'package:justap/services/remote_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MediaController extends GetxController {
  var isLoading = true.obs;
  var mediaList = <Media>[].obs;

  @override
  void onInit() {
    fetchMedias();
    super.onInit();
  }

  void fetchMedias() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      isLoading(true);
      if (uid != null) {
        var medias = await RemoteServices.fetchMedias(uid, false);
        if (medias != null) {
          mediaList.value = medias as List<Media>;
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
