import 'package:get/get.dart';
import 'package:naturemedix/controllers/clientrqst_controller.dart';
import 'package:naturemedix/controllers/dashboard_controller.dart';
import 'package:naturemedix/controllers/onboarding_controller.dart';
import 'package:naturemedix/controllers/splash_controller.dart';
import '../controllers/bookmark_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/plantInfo_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/register_controller.dart';

class InitDep implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies'
    Get.lazyPut(() => OnboardingController());
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => PlantInfoController());
    Get.lazyPut(() => BookmarkController());
    Get.lazyPut(() => ClientRequestController());
    Get.lazyPut(() => ProfileController());
  }
}
