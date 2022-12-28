import 'package:get/state_manager.dart';
import 'package:justap/models/reward.dart';
import 'package:justap/services/remote_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RewardController extends GetxController {
  var isLoading = true.obs;
  var rewardList = <Reward>[].obs;

  @override
  void onInit() {
    fetchRewards();
    super.onInit();
  }

  void fetchRewards() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      isLoading(true);
      //if (uid != null) {
      var reward = await RemoteServices.fetchRewards();
      if (reward.isNotEmpty) {
        rewardList.value = reward as List<Reward>;
      } else {
        rewardList.value = [];
      }
      //}
    } finally {
      isLoading(false);
    }
  }
}
