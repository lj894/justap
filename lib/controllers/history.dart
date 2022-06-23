import 'package:get/state_manager.dart';
import 'package:justap/models/history.dart';
import 'package:justap/services/remote_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryController extends GetxController {
  var isLoading = true.obs;
  var historyList = <History>[].obs;

  @override
  void onInit() {
    fetchHistory();
    super.onInit();
  }

  void fetchHistory() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      isLoading(true);
      if (uid != null) {
        var history = await RemoteServices.fetchHistory();
        if (history.isNotEmpty) {
          historyList.value = history as List<History>;
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
