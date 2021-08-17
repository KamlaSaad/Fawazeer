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

Widget mainBtn(String txt, String pageTitle) {
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
    onTap: () => Get.to(QuestionView(pageTitle)),
  );
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
Widget letterBox(String txt) {
  var box = Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    decoration:
        BoxDecoration(color: boxColor, borderRadius: BorderRadius.circular(5)),
    width: Get.width * 0.135,
    height: Get.height * 0.05,
    child: Center(
      child: Txt(txt, 22, textColor, true),
    ),
  );
  return GestureDetector(
    child: box,
    onTap: () async {
      var txt = (((box as Container).child as Center).child as Text).data;
      controller.addTxt("$txt");
      if (controller.i.value == controller.rightAnswer.length) {
        Timer(Duration(milliseconds: 200), () async {
          if (controller.userAnswer.toString() ==
              controller.rightAnswer.toString()) {
            dialogMsg("👏 احسنت ", "اجابة صحيحة", "التالي", "خروج", mainColor2,
                () {
              Get.back();
              print("next");
            }, () => Get.offAll(Home()));
            controller.userScores.value += controller.questionScore.value;
            await audioCache.play('audios/success.mp3');
          } else {
            dialogMsg("😐 للاسف", "اجابة خطأ", " ", "حاول مرة اخري", mainColor1,
                () => Get.back(), () {
              Get.back();
              controller.reset();
            });
            await audioCache.play('audios/failure.mp3');
          }
        });
      }
    },
  );
}

void dialogMsg(String title, String content, String confirmText,
    String cancelText, Color color, Function confirm, Function cancel) {
  Get.defaultDialog(
    title: title,
    titleStyle:
        TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 28),
    content: Txt(content, 23, textColor, false),
    contentPadding: const EdgeInsets.all(5),
    cancelTextColor: textColor,
    cancel: dialogBtn(cancelText, color, false, cancel),
    confirm: confirmText == " "
        ? null
        : dialogBtn(confirmText, color, true, confirm),
    backgroundColor: bodyColor,
  );
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
