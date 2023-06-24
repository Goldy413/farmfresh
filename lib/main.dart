import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:farmfresh/utility/custom_scroll_behaviour.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppStorage.objectValue();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData _lightTheme = ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: ThemeData.light(useMaterial3: true).colorScheme.copyWith(
            primary: const Color(0XFF238438),
            onPrimary: const Color(0XFFFFBF00),
            background: const Color(0xFFF8F8F8),
          ),
      primaryColor: const Color(0XFF238438),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0XFFFFBF00),
        disabledColor: Colors.white,
      ));

  final ThemeData _darkTheme = ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: ThemeData.light(useMaterial3: true).colorScheme.copyWith(
          primary: const Color(0XFF238438),
          onPrimary: const Color(0XFFFFBF00),
          onBackground: const Color(0xFF232323)),
      primaryColor: const Color(0XFF238438),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0XFFFFBF00),
        disabledColor: Colors.white,
      ));

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp.router(
              scrollBehavior: CustomScrollBehaviour(),
              title: const String.fromEnvironment('APP_NAME'),
              debugShowCheckedModeBanner: false,
              theme: _lightTheme,
              darkTheme: _darkTheme,
              themeMode: ThemeMode.light,
              routerConfig: router,
            ));
  }
}
