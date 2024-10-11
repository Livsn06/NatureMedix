import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  bool _hasInternet = false;
  bool get hasInternet => _hasInternet;

  InternetController() {
    checkInternetConnection();
  }

  Future checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _hasInternet = false;
    } else {
      _hasInternet = true;
    }
    update();
  }
}
