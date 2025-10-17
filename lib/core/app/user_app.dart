import 'package:ordering_app/core/services/get_it_services.dart';
import 'package:ordering_app/core/services/secure_storage.dart';

class UserApp {
  static bool isAuthorized = false;
  static Future<void> userIsAuthorized() async {
    String? uthorized = await GetItServices.getIt<SecureStorage>()
        .getUserData();
    isAuthorized = (uthorized != null);
    // if (isAuthorized) {
    //   await ConnectionsServices.initConnection();
    // }
  }
}

class CoachApp {
  static bool isCoachAuthorized = false;
  static Future<void> coachIsAuthorized() async {
    String? uthorized = await GetItServices.getIt<SecureStorage>()
        .getCoachData();
    isCoachAuthorized = (uthorized != null);
    // if (isAuthorized) {
    //   await ConnectionsServices.initConnection();
    // }
  }
}
