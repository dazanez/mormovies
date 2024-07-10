import 'package:flutter/material.dart';

import 'package:mormovies/config/router/app_router.dart';
import 'package:mormovies/config/theme/app_theme.dart';
 
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
