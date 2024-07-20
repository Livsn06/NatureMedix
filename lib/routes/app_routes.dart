import 'package:go_router/go_router.dart';
import 'package:naturemedix/screens/homescreen.dart';
import 'package:naturemedix/screens/mainscreen.dart';
import 'package:naturemedix/screens/splashscreen.dart';

GoRouter app_routes = GoRouter(
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (context, state) => const Mainscreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'Splashscreen',
            builder: (context, state) => const Splashscreen(),
          ),
          GoRoute(
            path: 'Homescreen',
            builder: (context, state) => const Homescreen(),
          )
        ])
  ],
);
