import 'package:get/get.dart';
import 'package:naturemedix/screens/authentication/login_screen.dart';
import 'package:naturemedix/screens/authentication/register_screen.dart';
import 'package:naturemedix/screens/onboarding/getstatrted_screen.dart';
import 'package:naturemedix/screens/onboarding/onboarding_screen.dart';

import '../screens/authentication/action_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/splash/splash_screen.dart';

class ScreenRouter {
  static const _home = '/';
  static const _splash = '/splash';
  static const _getstarted = '/started';
  static const _onboarding = '/onboard';
  static const _chooseaction = '/chooseaction';
  static const _login = '/login';
  static const _register = '/register';

  static String get getSplashscreenRoute => _splash;
  static String get getHomescreenRoute => _home;
  static String get getGetstartedRoute => _getstarted;
  static String get getOnboardingRoute => _onboarding;
  static String get getChooseactionRoute => _chooseaction;
  static String get getLoginRoute => _login;
  static String get getRegisterRoute => _register;

  static List<GetPage> routes = [
    GetPage(
      name: _splash,
      page: () => SplashScreen(),
      preventDuplicates: true,
    ),
    GetPage(
      name: _home,
      page: () => const HomeScreen(),
      preventDuplicates: true,
    ),
    GetPage(
      name: _getstarted,
      page: () => GetstartedScreen(),
      preventDuplicates: true,
    ),
    GetPage(
      name: _onboarding,
      page: () => OnboardingScreen(),
      preventDuplicates: true,
    ),
    GetPage(
      name: _chooseaction,
      page: () => const ChooseactionScreen(),
      preventDuplicates: true,
    ),
    GetPage(
      name: _login,
      page: () => const LoginScreen(),
      preventDuplicates: true,
    ),
    GetPage(
      name: _register,
      page: () => const RegisterScreen(),
      preventDuplicates: true,
    ),
  ];
}
