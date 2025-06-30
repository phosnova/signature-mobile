import 'package:flutter/material.dart';

import 'core/app_config.dart';
import 'core/themes/input_decoration_theme.dart';
import 'router/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: MyAppConfig.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        inputDecorationTheme: inputDecorationTheme,
      ),
      debugShowCheckedModeBanner: false, // default: true or other best partice: !kReleaseMode
      routerConfig: goRouter,
      // locale: const Locale('id', 'ID'),
    );
  }
}
