import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naturemedix/helpers/_init_dependencies.dart';
import 'package:naturemedix/routes/screen_routes.dart';
import 'package:naturemedix/screens/onboarding/getstatrted_screen.dart';
import 'package:naturemedix/screens/onboarding/onboarding_screen.dart';
import 'package:naturemedix/screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitDep(),
      initialRoute: ScreenRouter.getHomescreenRoute,
      getPages: ScreenRouter.routes,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
