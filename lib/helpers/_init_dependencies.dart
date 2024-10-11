import 'package:get/get.dart';
import 'package:naturemedix/controllers/Home_Control/clientrqst_controller.dart';
import 'package:naturemedix/controllers/Home_Control/dashboard_controller.dart';
import 'package:naturemedix/controllers/WalkThru_Control/onboarding_controller.dart';
import 'package:naturemedix/controllers/WalkThru_Control/splash_controller.dart';
import '../controllers/Home_Control/bookmark_controller.dart';
import '../controllers/Home_Control/home_controller.dart';
import '../controllers/Auth_Control/login_controller.dart';
import '../controllers/Internet_Control/internet_controller.dart';
import '../controllers/PlantInfo_Control/plantInfo_controller.dart';
import '../controllers/Home_Control/profile_controller.dart';
import '../controllers/Auth_Control/register_controller.dart';

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
    Get.lazyPut(() => InternetController());
  }
}
