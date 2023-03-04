import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/action_button.dart';

class PdfViewer extends StatefulWidget {
  static const String id = '/pdf_view';
  final String path;

  const PdfViewer({Key? key, required this.path}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool pdfReady = false;
  int _totalPage = 0;
  bool isNightMode = false;
  bool renderOverlay = true;
  bool visible = true;
  bool switchLabelPosition = false;
  bool extend = false;
  bool mini = false;
  bool rmicons = false;
  bool customDialRoot = false;
  bool closeManually = false;
  bool useRAnimation = true;
  ValueNotifier<bool> isDialOpen = ValueNotifier<bool>(false);
  SpeedDialDirection speedDialDirection = SpeedDialDirection.up;
  Size buttonSize = const Size(56.0, 56.0);
  Size childrenButtonSize = const Size(56.0, 56.0);
  int? initialPage;
  int? currentPage;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  //add the current page to shared preferences

  Future<void> savePage(int index) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('pageIndex', index);
  }

  //get the saved page from shared preferences

  Future<bool> getPage() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('pageIndex') != null) {
      setState(() {
        initialPage = prefs.getInt('pageIndex')!;
      });
      return true;
    } else {
      initialPage = 0;
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getPage();
  }

  @override
  Widget build(BuildContext context) {
    if (initialPage != null) {
      return WillPopScope(
        onWillPop: () async {
          if (isDialOpen.value) {
            isDialOpen.value = false;
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      isNightMode ? Colors.white : Colors.black,
                      BlendMode.difference),
                  child: PDFView(
                    filePath: widget.path,
                    defaultPage: initialPage!,
                    autoSpacing: true,
                    enableSwipe: true,
                    pageSnap: true,
                    swipeHorizontal: false,
                    onError: (e) {
                      print(e);
                    },
                    onRender: (_pages) {
                      setState(() {
                        _totalPage = _pages!;
                        pdfReady = true;
                      });
                    },
                    onViewCreated: (PDFViewController pdfViewController) {
                      _controller.complete(pdfViewController);
                    },
                    onPageChanged: (int? page, int? total) {
                      currentPage = page;
                    },
                    onPageError: (page, e) {},
                  ),
                ),
                !pdfReady
                    ? const Center(child: CircularProgressIndicator())
                    : const Offstage()
              ],
            ),
          ),
          floatingActionButton: SpeedDial(
            animationDuration: const Duration(milliseconds: 400),
            backgroundColor: Colors.deepPurple.shade600,
            icon: Icons.add,
            activeIcon: Icons.close,
            spacing: 3,
            elevation: 8,
            childPadding: const EdgeInsets.all(5),
            spaceBetweenChildren: 4,
            mini: mini,
            openCloseDial: isDialOpen,
            buttonSize: buttonSize,
            childrenButtonSize: childrenButtonSize,
            visible: visible,
            direction: speedDialDirection,
            switchLabelPosition: switchLabelPosition,
            closeManually: closeManually,
            renderOverlay: renderOverlay,
            animationCurve: Curves.elasticInOut,
            isOpenOnStart: false,
            useRotationAnimation: useRAnimation,
            shape: customDialRoot
                ? const RoundedRectangleBorder()
                : const StadiumBorder(),
            children: [
              SpeedDialChild(
                child: ActionButton(
                  icon: const Icon(
                    Icons.share_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Share.share(
                      'https://play.google.com/store/apps/details?id=com.example.pdf_pro',
                    );
                  },
                ),
                label: "مشاركة التطبيق",
                labelBackgroundColor: Colors.black,
                labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              SpeedDialChild(
                child: ActionButton(
                  icon: const Icon(
                    Icons.save,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (currentPage != null) {
                      savePage(currentPage!);
                    }
                  },
                ),
                label: "الحفظ التلقائي",
                labelBackgroundColor: Colors.black,
                labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              SpeedDialChild(
                child: ActionButton(
                  icon: const Icon(
                    Icons.nightlight,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      isNightMode = !isNightMode;
                    });
                  },
                ),
                label: 'الوضع الليلي',
                labelBackgroundColor: Colors.black,
                labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              SpeedDialChild(
                child: ActionButton(
                  icon: const Icon(
                    Icons.window,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                label: "الفهرس",
                labelBackgroundColor: Colors.black,
                labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
