import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf_pro/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkEnabled = false;
  ThemeMode _themeMode = ThemeMode.light;

  bool changeTheme() {
    isDarkEnabled = !isDarkEnabled;

    setState(() {
      _themeMode = isDarkEnabled ? ThemeMode.dark : ThemeMode.light;
    });
    return isDarkEnabled;
  }

  Future<void> getTheSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('theme') != null) {
      if (prefs.getBool('theme') == true) {
        setState(() {
          isDarkEnabled = true;
          _themeMode = ThemeMode.dark;
        });
      } else {
        setState(() {
          isDarkEnabled = false;
          _themeMode = ThemeMode.light;
        });
      }
    }
  }

  @override
  void initState() {
    getTheSavedTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          theme: ThemeData.light(),
          themeMode: _themeMode,
          home: SplashScreen(),
        );
      },
    );
  }
}
