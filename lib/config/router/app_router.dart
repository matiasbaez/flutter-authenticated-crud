import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:shop/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [

    GoRoute(
      path: '/splash',
      builder: (context, state) => const CheckAuthStatusScreen(),
    ),

    // Auth Routes
    GoRoute(
      path: '/auth',
      builder: (context, state) => const Center(),
      routes: [
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginScreen(),
        ),

        GoRoute(
          path: 'register',
          builder: (context, state) => const RegisterScreen(),
        ),
      ]
    ),

    ///* Product Routes
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsScreen(),
    ),
  ],
  ///! TODO: Bloquear si no se está autenticado de alguna manera
);