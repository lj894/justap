import 'package:get/state_manager.dart';
import 'package:justap/models/media.dart';
import 'package:justap/services/remote_services.dart';

class ROMediaController extends GetxController {
  var isLoading = true.obs;
  var ro_mediaList = <Media>[].obs;

  @override
  void onInit() {
    //String? code = Uri.base.queryParameters["code"];
    String redirectURL = Uri.base.toString();
    String regexString =
        r'[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12}';
    RegExp regExp = RegExp(regexString);
    RegExpMatch? match = regExp.firstMatch(redirectURL);
    String? code = match?.group(0);

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
