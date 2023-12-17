import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop/config/router/app_router_notifier.dart';
import 'package:shop/presentation/providers/providers.dart';

import 'package:shop/presentation/screens/screens.dart';



final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
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

    redirect: (context, state) {

      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) return null;
      if (authStatus == AuthStatus.notAuthenticated) {
        if (['/auth/login', '/auth/register'].contains(isGoingTo)) return null;
        return '/auth/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (['/auth/login', '/auth/register', '/splash'].contains(isGoingTo)) return '/';
      }

      return null;
    }

  );
});
