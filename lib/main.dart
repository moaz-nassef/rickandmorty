import 'package:flutter/material.dart';
import 'package:rickandmorty/app_routes.dart';
import 'package:rickandmorty/consstant/string.dart';

void main() {
  runApp(RickAndMortyApp(appRoutes: AppRoutes()));
}

class RickAndMortyApp extends StatelessWidget {
  final AppRoutes appRoutes;

  const RickAndMortyApp({super.key, required this.appRoutes});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Mycoloer.myyellow,
      brightness: Brightness.dark,
      surface: const Color(0xff1e282f),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: Mycoloer.mygray,
        splashFactory: InkSparkle.splashFactory,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: _PortalPageTransitionsBuilder(),
            TargetPlatform.iOS: _PortalPageTransitionsBuilder(),
            TargetPlatform.windows: _PortalPageTransitionsBuilder(),
            TargetPlatform.macOS: _PortalPageTransitionsBuilder(),
            TargetPlatform.linux: _PortalPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: AllcharacterScreen,
      onGenerateRoute: appRoutes.generateRoutes,
    );
  }
}

class _PortalPageTransitionsBuilder extends PageTransitionsBuilder {
  const _PortalPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return child;
    }

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    return FadeTransition(
      opacity: curvedAnimation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.96, end: 1).animate(curvedAnimation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.03, 0.02),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        ),
      ),
    );
  }
}
