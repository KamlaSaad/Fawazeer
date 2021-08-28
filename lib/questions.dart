import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'shared.dart';

class QuestionView extends GetView<QuestionController> {
  var controller = Get.put(QuestionController());
  List data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: null,
      body: FutureBuilder(
//          itemCount: 1,
          builder: (context, i) {
        return Container(
          width: Get.width,
          height: Get.height,
          child: Center(
              child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
                padding: EdgeInsets.only(top: Get.height * 0.07),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => btnBox(
                              mainColor1,
                              " النقود ${controller.userScores.value}",
                              Get.width / 2,
                              0,
                              () => null),
                        ),
                        Obx(() => btnBox(
                            mainColor2,
                            "المستوي ${controller.questionList[controller.index.value]["level"]}",
                            Get.width / 2,
                            0,
                            () => null))
                      ],
                    ),
                    Spacer(),
                    Spacer(),
                    //question
                    Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          color: boxColor,
                          borderRadius: BorderRadius.circular(5)),
                      width: Get.width * 0.75,
                      child: Center(
                          child: Obx(
                        () => Txt(
                            controller.questionList[controller.index.value]
                                ['question'],
                            22,
                            textColor,
                            true),
                      )),
                    ),
                    Spacer(),
                    Spacer(),
                    SizedBox(
                      width: Get.width * 0.94,
                      height: Get.height * 0.05,
                      child: Obx(() => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.answerLength.value,
                          itemBuilder: (context, i) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueGrey, width: 1),
                                  color: boxColor,
                                  borderRadius: BorderRadius.circular(5)),
                              width: (Get.width * 0.85) /
                                  controller.rightAnswer.length,
                              height: Get.height * 0.05,
                              child: Center(
                                child: Obx(() => Txt(
                                    "${i < (controller.userAnswer.length) ? controller.userAnswer.value[i] : " "}",
                                    22,
                                    textColor,
                                    true)),
                              ),
                            );
                          })),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        btnBox(mainColor2, "مساعدة", Get.width * 0.44, 6, () {
                          controller.reset();
                          if (controller.rightAnswer.length > 1) {
                            dialogMsg(
                                "مساعدة ",
                                "كشف اول حرف مقابل ${controller.questionScore.value} قطعة نقود",
                                "موافق",
                                "الغاء",
                                mainColor2,
                                () => controller.help1(),
                                () => Get.back());
                          } else {
                            dialogMsg(
                                "مساعدة ",
                                "كشف الاجابة مقابل ${2 * controller.questionScore.value}  نقود",
                                "موافق",
                                "الغاء",
                                mainColor2,
                                () => controller.help2(),
                                () => Get.back());
                          }
                        }),
                        btnBox(mainColor1, "تخطي", Get.width * 0.44, 6, () {
                          controller.reset();
                          controller.questionScore.value = controller
                              .questionList[controller.index.value]['score'];
                          dialogMsg(
                              "تخطي",
                              "تخطي السؤال مقابل ${controller.questionScore * 2}  نقود",
                              "موافق",
                              "الغاء",
                              mainColor2,
                              () => controller.index.value <
                                      controller.questionList.length - 1
                                  ? controller.skip1()
                                  : controller.skip2(),
                              () => Get.back());
                        })
                      ],
                    ),
                    Spacer(),
                    lettersList(true),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    lettersList(false),
                    Spacer(),
                  ],
                )),
          )),
        );
      }),
    );
  }
}

List<Widget> widgets = [];
Widget answerList() {
  int answerLength =
      controller.questionList[controller.index.value]['answer'].length;
  print("answerLength :${answerLength}");
  for (int i = 0; i < answerLength; i++) {
    widgets.add(Container(
//      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey, width: 1),
          color: boxColor,
          borderRadius: BorderRadius.circular(5)),
      width: (Get.width * 0.9) / answerLength,
      height: Get.height * 0.05,
      child: Center(
        child: Obx(() => Txt(
            "${i < (controller.userAnswer.length) ? controller.userAnswer.value[i] : " "}",
            22,
            textColor,
            true)),
      ),
    ));
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: widgets,
  );
}
