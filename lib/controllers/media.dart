import 'package:get/state_manager.dart';
import 'package:justap/models/media.dart';
import 'package:justap/services/remote_services.dart';

class MediaController extends GetxController {
  var isLoading = true.obs;
  var mediaList = <Media>[].obs;

  @override
  void onInit() {
    fetchMedias();
    super.onInit();
  }

  void fetchMedias() async {
    try {
      isLoading(true);
      var medias = await RemoteServices.fetchMedias();
      if (medias != null) {
        mediaList.value = medias as List<Media>;
      }
    } finally {
      isLoading(false);
    }
  }
}
