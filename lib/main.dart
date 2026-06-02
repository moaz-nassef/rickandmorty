import 'package:flutter/material.dart';
import 'package:rickandmorty/app_routes.dart';

void main() {
  runApp(RickAndMortyApp(appRoutes: AppRoutes()));
}

class RickAndMortyApp extends StatelessWidget {
  final AppRoutes appRoutes;

  const RickAndMortyApp({super.key, required this.appRoutes});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoutes.generateRoutes,
    );
  }
}
  