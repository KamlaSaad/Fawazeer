import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:gradient_text/gradient_text.dart';
import 'questions.dart';
import 'shared.dart';
import 'model.dart';

void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bodyColor.withOpacity(0.6),
        appBar: null,
        body: Container(
          margin: const EdgeInsets.all(0),
          width: Get.width,
          height: Get.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
//                      GradientText(
//                        "الغاز وفوازير",
//                        style: TextStyle(
//                            fontSize: 40, fontWeight: FontWeight.bold),
//                        gradient:
//                            LinearGradient(colors: [mainColor1, mainColor2]),
//                      ),
                      Row(
                        children: [
                          Txt("الغاز", 45, mainColor1, true),
                          Txt(" وفوازير", 45, mainColor2, true),
                        ],
                      ),

//                      IconButton(
//                          onPressed: () => Get.to(QuestionView("tle")),
//                          icon: Icon(
//                            Icons.settings,
//                            color: textColor,
//                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                mainBtn("اسئلة عامة", commonQuestions),
                mainBtn("قران", quranQuestions),
                mainBtn("رياضيات", mathQuestions),
                mainBtn("علوم", scienceQuestions),
                mainBtn("تاريخ وجغرافيا", tgQuesstions),
                mainBtn("فنون", artQuestions),
                mainBtn("تكنولوجيا", commonQuestions),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
