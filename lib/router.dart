import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sos_pet/screens/home_screen.dart';
import 'package:sos_pet/screens/report_pet_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'report',
          builder: (BuildContext context, GoRouterState state) {
            return const ReportPetScreen();
          },
        ),
      ],
    ),
  ],
);
