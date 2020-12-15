import 'package:f1fantasy/constants/app_constants.dart';
import 'package:f1fantasy/services/native/pref_service.dart';

class AppReviewService {
  static final AppReviewService _instance = AppReviewService._internal();
  final PrefService cache = PrefService();
  factory AppReviewService() {
    return _instance;
  }
  AppReviewService._internal();

  Future<void> userReviewed() async {
    await cache.writData(AppConstants.reviewed, "Y");
  }

  Future<void> remindLater(int number) async {
    int next = number + 2;
    await cache.writData(AppConstants.toReview, next.toString());
  }

  Future<bool> shouldReview(int roundNumber) async {
    String hasDone = await cache.readDate(AppConstants.reviewed);
    String first = await cache.readDate("firstInstallation");
    if (first == "Y") {
      await cache.writData("firstInstallation", "N");
      return false;
    }
    if (hasDone == "Y") {
      return false;
    }
    int reviewNumber = int.parse(await cache.readDate(AppConstants.toReview));
    if (reviewNumber == roundNumber) {
      return true;
    }
    return false;
  }

  Future<void> initialize() async {
    await cache.writData(AppConstants.toReview, "6");
    await cache.writData(AppConstants.reviewed, "N");
    await cache.writData("firstInstallation", "Y");
  }
}
