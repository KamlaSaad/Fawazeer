import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'shared.dart';

class QuestionView extends GetView<QuestionController> {
  String title = "";
  QuestionView(String tle) {
    title = tle;
  }
  var controller = Get.put(QuestionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: null,
      body: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.only(top: Get.height * 0.07),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    btnBox(mainColor1, " النقود ${controller.userScores} ",
                        Get.width / 2, 0, () {}),
                    btnBox(mainColor2, "المستوي الاول", Get.width / 2, 0, () {})
                  ],
                ),
                Spacer(),
                Spacer(),
                //question
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      color: boxColor, borderRadius: BorderRadius.circular(5)),
                  width: Get.width * 0.75,
                  child: Center(
                    child: Txt("ماهو الشيء الدي ليس بانسان ولا حيوان ", 22,
                        textColor, true),
                  ),
                ),
                Spacer(),
                Spacer(),
                SizedBox(
                  width: Get.width * 0.94,
                  height: Get.height * 0.05,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.rightAnswer.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.blueGrey, width: 1),
                              color: boxColor,
                              borderRadius: BorderRadius.circular(5)),
                          width:
                              (Get.width * 0.8) / controller.rightAnswer.length,
                          height: Get.height * 0.05,
                          child: Center(
                            child: Obx(() => Txt(
                                "${i < (controller.userAnswer.length) ? controller.userAnswer.value[i] : ""}",
                                22,
                                textColor,
                                true)),
                          ),
                        );
                      }),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btnBox(mainColor2, "مساعدة", Get.width * 0.44, 6, () {
                      dialogMsg(
                          "مساعدة ",
                          "كشف اول حرف مقابل قطعة نقود",
                          "موافق",
                          "الغاء",
                          mainColor2,
                          () => controller.help(), () {
                        controller.reset();
                        Get.back();
                      });
                    }),
                    btnBox(mainColor1, "تخطي", Get.width * 0.44, 6, () {
                      dialogMsg(
                          "تخطي",
                          "تخطي السؤال مقابل ${controller.questionScore} قطعة نقود",
                          "موافق",
                          "الغاء",
                          mainColor2,
                          () => controller.skip(), () {
                        controller.reset();
                        Get.back();
                      });
                    })
                  ],
                ),
                Spacer(),
                Letters(true),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Letters(false),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Letters(bool first) {
    return SizedBox(
        width: Get.width * 0.97,
        height: Get.height * 0.05,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, i) {
              var lastItems =
                  controller.possibleLetters.skip(6).take(6).toList();
              return letterBox(
                  "${controller.possibleLetters.isEmpty ? "" : (first ? controller.possibleLetters.value[i] : lastItems[i])}");
            }));
  }
}
