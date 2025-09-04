import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uae_meditation_center/presentation/pages/account%20settings/account.settings.dart';
import 'package:uae_meditation_center/presentation/pages/animation%20settings/animation.settings.dart';
import 'package:uae_meditation_center/presentation/pages/help%20and%20supports/help.and.support.dart';
import 'package:uae_meditation_center/presentation/screens/auth/screens/create.screen.dart';
import 'package:uae_meditation_center/presentation/screens/auth/screens/forgot.password.dart';
import 'package:uae_meditation_center/presentation/screens/auth/screens/login.screen.dart';
import 'package:uae_meditation_center/presentation/screens/auth/screens/verify.screen.dart';
import 'package:uae_meditation_center/presentation/screens/main/main.screen.dart';
import 'package:uae_meditation_center/presentation/screens/settings/settings.screen.dart';
import 'package:uae_meditation_center/presentation/screens/splash/splash.screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouting {

  final int duration;
  late final GoRouter appRouter;

  AppRouting({required this.duration}) {
    appRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: FirebaseAuth.instance.currentUser != null ? '/main' : '/',
      // initialLocation: '/account_settings',
      routes: [
        _route(
          '/',
          'splash',
          false,
          SplashScreen(),
          duration,
        ),
        _route(
          '/login',
          'login',
          false,
          LoginScreen(),
          duration,
        ),
        _route(
          '/create',
          'create',
          false,
          CreateScreen(),
          duration,
        ),
        _route(
          '/forgot',
          'forgot',
          false,
          ForgotPassword(),
          duration,
        ),
        _route(
          '/verify',
          'verify',
          false,
          VerifyScreen(),
          duration,
        ),
        _route(
          '/main',
          'main',
          false,
          MainScreen(),
          duration,
        ),
        _route(
          '/settings',
          'settings',
          false,
          SettingsScreen(),
          duration,
        ),
        _route(
          '/account_settings',
          'account_settings',
          false,
          AccountSettings(),
          duration,
        ),
        _route(
          '/animation_settings',
          'animation_settings',
          false,
          AnimationSettings(),
          duration,
        ),
        _route(
          '/help_and_support',
          'help_and_support',
          false,
          HelpAndSupport(),
          duration,
        ),
      ],
    );
  }
}

GoRoute _route(
  String path,
  String name,
  bool isRightSlide,
  Widget page,
  int duration,
) {
  return GoRoute(
    path: path,
    name: name,
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionDuration: Duration(seconds: duration),
      reverseTransitionDuration: Duration(seconds: duration),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //  const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;

        final tween = Tween(
                begin: isRightSlide ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0),
                end: end)
            .chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}
