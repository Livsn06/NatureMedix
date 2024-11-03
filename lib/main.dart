import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:naturemedix/helpers/_init_dependencies.dart';
import 'package:naturemedix/routes/screen_routes.dart';
import 'package:naturemedix/screens/splash/splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'firebase_options.dart';
import 'models/client_data.dart';
import 'models/plant_info.dart';
import 'models/rating_data.dart';
import 'models/remedy_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(PlantDataAdapter());
  Hive.registerAdapter(RemedyInfoAdapter());
  Hive.registerAdapter(RatingDataAdapter());
  Hive.registerAdapter(ClientDataAdapter());
  await Hive.openBox('bookmarks');
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key}) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitDep(),
      initialRoute: ScreenRouter.getSplashscreenRoute,
      getPages: ScreenRouter.routes,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
