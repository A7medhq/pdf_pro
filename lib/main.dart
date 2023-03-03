import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf_pro/screens/splash_screen.dart';


void main() {
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
         designSize: const Size(360, 690),
         minTextAdapt: true,
         splitScreenMode: true,
         builder: (context,child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  SplashScreen(),
        );
      },

    );
  }
}



