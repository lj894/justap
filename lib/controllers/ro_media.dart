import 'package:get/state_manager.dart';
import 'package:justap/models/media.dart';
import 'package:justap/services/remote_services.dart';

class ROMediaController extends GetxController {
  var isLoading = true.obs;
  var ro_mediaList = <Media>[].obs;

  @override
  void onInit() {
    String? uid = Uri.base.queryParameters["uid"];
    fetchROMedias(uid);
    super.onInit();
  }

  void fetchROMedias(uid) async {
    try {
      isLoading(true);
      var ro_medias = await RemoteServices.fetchMedias(uid);
      if (ro_medias != null) {
        ro_mediaList.value = ro_medias as List<Media>;
      }
    } finally {
      isLoading(false);
    }
  }
}
