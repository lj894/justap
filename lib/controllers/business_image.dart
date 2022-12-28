import 'package:get/state_manager.dart';
import 'package:justap/models/business_image.dart';
import 'package:justap/services/remote_services.dart';

class BusinessImageController extends GetxController {
  var isLoading = true.obs;
  var businessImageList = <BusinessImage>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchBusinessImage(id) async {
    try {
      isLoading(true);
      var result = await RemoteServices.fetchBusinessImage(id);
      businessImageList.value = [];
      if (result.length > 0) {
        businessImageList.value = result as List<BusinessImage>;
      } else {
        businessImageList.value = [];
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
