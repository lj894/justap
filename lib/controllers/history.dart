import 'package:get/state_manager.dart';
import 'package:justap/models/history.dart';
import 'package:justap/services/remote_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TabHistoryController extends GetxController {
  var isLoading = true.obs;
  var historyList = <TabHistory>[].obs;

  @override
  void onInit() {
    fetchTabHistory();
    super.onInit();
  }

  void fetchTabHistory() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      isLoading(true);
      //if (uid != null) {
      var history = await RemoteServices.fetchTabHistory();
      if (history.isNotEmpty) {
        historyList.value = history as List<TabHistory>;
      } else {
        historyList.value = [];
      }
      //}
    } finally {
      isLoading(false);
    }
  }
}
