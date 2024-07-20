import 'package:flutter/material.dart';
import 'package:naturemedix/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'providers/sample.dart';

void main() {
  runApp(const MainApp());
}

  
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => SampleProvider())],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: app_routes,
        ),
      );
}
