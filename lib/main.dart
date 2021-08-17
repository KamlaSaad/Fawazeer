import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_text/gradient_text.dart';
import 'questions.dart';
import 'shared.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      getPages: [
        GetPage(name: "/common", page: () => QuestionView("common")),
      ],
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bodyColor,
        appBar: null,
        body: Container(
          margin: const EdgeInsets.all(0),
          width: Get.width,
          height: Get.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GradientText(
                        "الغاز وفوازير",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                        gradient:
                            LinearGradient(colors: [mainColor1, mainColor2]),
                      ),
                      IconButton(
                          onPressed: () => Get.to(QuestionView("tle")),
                          icon: Icon(
                            Icons.settings,
                            color: textColor,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                mainBtn("اسئلة عامة", "common"),
                mainBtn("قران", "quran"),
                mainBtn("رياضيات", "math"),
                mainBtn("علوم", "science"),
                mainBtn("تاريخ وجغرافيا", "history"),
                mainBtn("فنون", "art"),
                mainBtn("تكنولوجيا", "technology"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
