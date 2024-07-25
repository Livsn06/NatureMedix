import 'package:flutter/material.dart';
import 'package:naturemedix/providers/walkthrough_provider.dart';
import 'package:naturemedix/routes/app_routes.dart';

import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => WalkthroughProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, value, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: value.themeData,
              routerConfig: app_routes,
            );
          },
        ),
      );
}
