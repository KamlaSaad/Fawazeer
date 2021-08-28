import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'main.dart';
import 'questions.dart';
import 'controller.dart';

AudioPlayer player = AudioPlayer();
AudioCache audioCache = AudioCache(fixedPlayer: player);

//Colors
Color mainColor1 = Colors.red,
    mainColor2 = Colors.orange,
    textColor = Colors.white,
    boxColor = Color.fromRGBO(33, 33, 36, 1),
    bodyColor = Color.fromRGBO(16, 16, 16, 1);
Widget Txt(String txt, double size, Color color, bool bold) {
  return Text(
    txt,
    style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal),
  );
}

Widget mainBtn(String txt, List qList) {
  return GestureDetector(
      child: Container(
        width: Get.width * 0.75,
        height: Get.height * 0.08,
        decoration: BoxDecoration(
            border: Border.all(color: mainColor2, width: 1),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Txt(txt, 22, textColor, true),
        ),
      ),
      onTap: () {
        controller.questionList.value = qList;
        controller.assignVals();
        Get.to(QuestionView());
      });
}

Widget btnBox(Color color, String txt, double w, double r, click) {
  return GestureDetector(
    child: Container(
      width: w,
      height: Get.height * 0.065,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(r), color: color),
      child: Center(
        child: Txt(txt, 22, textColor, true),
      ),
    ),
    onTap: click,
  );
}

var controller = Get.put(QuestionController());
Widget lettersList(bool first) {
  var txt = "".obs;
  return SizedBox(
      width: Get.width * 0.97,
      height: Get.height * 0.05,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, i) {
            txt.value = controller.possibleLetters.isEmpty
                ? ""
                : (first
                    ? controller.possibleLetters[i]
                    : controller.lastItems[i]);
            var box = Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: boxColor, borderRadius: BorderRadius.circular(5)),
              width: Get.width * 0.135,
              height: Get.height * 0.05,
              child: Center(
                child: Obx(() => Txt(
                    controller.possibleLetters.isEmpty
                        ? ""
                        : (first
                            ? controller.possibleLetters[i]
                            : controller.lastItems[i]),
                    22,
                    textColor,
                    true)),
              ),
            );
            return GestureDetector(
              child: box,
              onTap: () async {
                controller.addTxt(
                    "${(first ? controller.possibleLetters[i] : controller.lastItems[i]).trim()}");
                if (controller.i.value == controller.rightAnswer.length) {
                  Timer(Duration(milliseconds: 100), () async {
                    if (controller.userAnswer.toString() ==
                        controller.rightAnswer.toString()) {
                      controller.questionScore.value = controller
                          .questionList[controller.index.value]['score'];
                      await audioCache.play('success.mp3');
                      controller.reset();
                      if (controller.index.value <
                          controller.questionList.length - 1) {
                        dialogMsg("👏 احسنت ", "اجابة صحيحة", "التالي", "خروج",
                            mainColor2, () {
                          Get.back();
                          controller.reset();
                          controller.index.value++;
                          controller.assignVals();
                        }, () => controller.exit());
                      } else {
                        dialogMsg(
                            "👏 تهانينا ",
                            "لقد انهيت جميع المستويات",
                            " ",
                            "خروج",
                            mainColor2,
                            () => null,
                            () => controller.exit());
                      }
                      controller.userScores.value +=
                          controller.questionScore.value;
                    } else {
                      controller.reset();
                      dialogMsg("😐 للاسف", "اجابة خطأ", " ", "حاول مرة اخري",
                          mainColor1, () => Get.back(), () => Get.back());
                      await audioCache.play('failure.mp3');
                    }
                  });
                }
              },
            );
          }));
}

void dialogMsg(String title, String content, String confirmText,
    String cancelText, Color color, Function confirm, Function cancel) {
  Get.defaultDialog(
      title: title,
      titleStyle:
          TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 28),
      content: Txt(content, 20, textColor, false),
      contentPadding: const EdgeInsets.all(5),
      cancelTextColor: textColor,
      cancel: dialogBtn(cancelText, color, false, cancel),
      confirm: confirmText == " "
          ? null
          : dialogBtn(confirmText, color, true, confirm),
      backgroundColor: bodyColor,
      barrierDismissible: false);
}

Widget dialogBtn(String text, Color color, bool backG, click) {
  return GestureDetector(
    child: Container(
        width: 120,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: backG ? color : Colors.transparent,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Txt(text, 19, textColor, false),
        )),
    onTap: click,
  );
}
