import 'package:go_router/go_router.dart';
import 'package:naturemedix/screens/homescreen.dart';
import 'package:naturemedix/screens/splashscreen.dart';

GoRouter app_routes = GoRouter(
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (context, state) => const Splashscreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'home',
            builder: (context, state) => const Homescreen(),
          )
        ])
  ],
);
