import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_pro/screens/pdfview.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String pdfPath = '';

  @override
  void initState() {
    super.initState();
    getPdfFromAsset('assets/book1.pdf').then((v) {
      setState(() {
        pdfPath = v.path;
      });
    });
    Future.delayed(const Duration(seconds: 4), () {
      if (pdfPath != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PdfViewer(
                      path: pdfPath,
                    )));
      }
    });
  }

  Future<File> getPdfFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/book1.pdf");
      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.jpeg',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'الدعاء المستجاب',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          // Image.asset('assets/splash.jpeg',fit: BoxFit.fill,height: double.infinity,)
        ],
      ),
    );
  }
}
