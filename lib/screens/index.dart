import 'package:flutter/material.dart';
import 'package:pdf_pro/screens/splash_screen.dart';

import '../models/index_model.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  List<IndexModel> indexList = [];

  List<IndexModel> getData() {
    List<IndexModel> models = [];
    models.add(IndexModel("المقدمة", 1, 0));
    models.add(IndexModel("الباب الأول: الدعاء", 7, 0));
    models.add(IndexModel("الفصل الأول" + " : " + "آداب الدعاء", 9, 0));

    models.add(IndexModel("الفصل الثاني: بركة الدعاء", 21, 0));

    models.add(IndexModel("الفصل الثالث: مواطن استجابة الدعاء", 31, 0));

    models.add(IndexModel("الفصل الرابع: الأدعية النبوية المأثورة", 42, 0));

    models.add(IndexModel("الفصل الخامس: الدعاء يرفعه العمل الصالح", 60, 0));
    models.add(IndexModel("الخوف من الإسلام . لماذا ؟", 62, 1));
    models.add(IndexModel("مفاتيح الأعمال الصالحة", 69, 1));
    models.add(IndexModel("أين نحن من السلف الصالح ؟", 73, 1));
    models.add(IndexModel("نماذج من الصالحين العابدين", 79, 1));
    models.add(IndexModel("آيات قرآنية فيمن أحبهم الله ", 87, 1));

    models.add(IndexModel(
        "الفصل السادس: فضل الأذكار والتسبيح .......... والاستغفار", 96, 0));
    models.add(IndexModel("فضل الذكر", 98, 1));
    models.add(IndexModel("آيات الذكر في القرآن الكريم", 101, 1));
    models.add(IndexModel("أعيان الأذكار النبوية في فضل الذكر ", 102, 1));
    models.add(IndexModel("فضل التسبيح والتحميد", 106, 1));
    models.add(IndexModel("آيات التسبيح في القرآن الكريم", 107, 1));
    models.add(IndexModel("الأذكار النبوية في فضل التسبيح والتحميد", 109, 1));
    models.add(IndexModel("فضل التهليل والتكبير", 113, 1));
    models.add(IndexModel("آيات التهليل والتكبير في القرآن الكريم", 114, 1));
    models.add(IndexModel("أذكار التهليل والتكبير من السنة النبوية", 116, 1));
    models.add(IndexModel("فضل الاستغفار", 118, 1));
    models.add(IndexModel("آيات الاستغفار في القرآن الكريم", 123, 1));
    models.add(IndexModel("الأذكار النبوية في فضل الاستغفار", 124, 1));

    models
        .add(IndexModel("الفصل السابع: فضل محبة الرسول والصلاة عليه", 130, 0));
    models.add(IndexModel("اسمه ولقبه", 132, 1));
    models.add(IndexModel("فضل الصلاة على الرسول", 135, 1));
    models.add(IndexModel("فضل محبة الرسول", 136, 1));
    models.add(IndexModel("فضائل الرسول", 140, 1));
    models.add(IndexModel("خصائص الرسول و معجزاته ", 141, 1));
    models.add(
        IndexModel("الأذكار النبوية في فضل محبة الرسول والصلاة عليه", 147, 1));

    models.add(IndexModel("الباب الثاني: القرآن العظيم", 156, 0));
    models.add(IndexModel("الفصل الأول: فضل القرآن الكريم", 158, 0));
    models.add(IndexModel("تدوين القرآن الكريم", 160, 1));
    models.add(IndexModel("معجزة القرآن", 164, 1));
    models.add(IndexModel("القرآن شفاء القلوب", 167, 1));
    models.add(IndexModel("فضل بعض سور القرآن", 196, 1));
    models.add(
        IndexModel("أعيان الأذكار النبوية في فضل الآيات القرآنية", 177, 1));
    models.add(
        IndexModel("أعيان الآيات القرآنية الدالة على عظمة القرآن", 179, 1));

    models.add(IndexModel("الفصل الثاني: فضل قراءة القرآن", 183, 0));
    models.add(IndexModel("حق تلاوة القرآن", 185, 1));
    models.add(IndexModel("فضل قراءة بعض سور القرآن", 192, 1));

    models.add(IndexModel("الفصل الثالث: الدعاء القرآني", 205, 0));
    models.add(IndexModel("دعاء الرسل عليهم السلام", 208, 1));
    models.add(IndexModel("دعوات قرآنية", 211, 1));

    models.add(IndexModel(
        "الفصل الرابع: التداوي بالقرآن الكريم والأدعية النبوية", 216, 0));
    models.add(IndexModel("الداء والدواء", 218, 1));
    models.add(IndexModel("العلاج بالقرآن الكريم", 222, 1));
    models.add(IndexModel("المصادر والمراجع ", 248, 1));
    models.add(IndexModel("المؤلف في سطور", 254, 1));

    return models;
  }

  @override
  void initState() {
    indexList = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade600,
        title: Text('الفهرس'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: indexList.length,
        itemBuilder: (context, index) {
          if (indexList.isNotEmpty) {
            return ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SplashScreen(
                              initPage: indexList[index].startPage - 1,
                            )));
              },
              title: Text(indexList[index].title),
              trailing: Text(
                  '${indexList[index].endPage.toString()} - ${indexList[index].startPage.toString()}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
