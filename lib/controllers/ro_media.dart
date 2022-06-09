import 'package:get/state_manager.dart';
import 'package:justap/models/media.dart';
import 'package:justap/services/remote_services.dart';

class ROMediaController extends GetxController {
  var isLoading = true.obs;
  var ro_mediaList = <Media>[].obs;

  @override
  void onInit() {
    String? code = Uri.base.queryParameters["code"];
    fetchROMedias(code);
    super.onInit();
  }

  void fetchROMedias(code) async {
    try {
      isLoading(true);
      var user = await RemoteServices.fetchUserByCode();
      var ro_medias = await RemoteServices.fetchMediasByCode(user.code);
      if (ro_medias != null) {
        ro_mediaList.value = ro_medias as List<Media>;
      }
    } finally {
      isLoading(false);
    }
  }
}
