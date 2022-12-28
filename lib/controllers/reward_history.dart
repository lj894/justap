import 'package:get/state_manager.dart';
import 'package:justap/models/reward_history.dart';
import 'package:justap/services/remote_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RewardHistoryController extends GetxController {
  var isLoading = true.obs;
  var rewardHistoryList = <RewardHistory>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchRewardHistory(id) async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      isLoading(true);
      if (uid != null) {
        var reward = await RemoteServices.fetchRewardHistory(id);
        if (reward.isNotEmpty) {
          rewardHistoryList.value = reward as List<RewardHistory>;
        } else {
          rewardHistoryList.value = [];
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
