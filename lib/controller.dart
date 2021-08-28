import 'dart:async';

import 'package:get/get.dart';
import 'shared.dart';
import 'main.dart';

class QuestionController extends GetxController {
  var questionList = [].obs,
      userAnswer = [].obs,
      answerLength = 0.obs,
      rightAnswer = [].obs,
      possibleLetters = [].obs,
      lastItems = [].obs,
      firstLetterOfAnswer = "".obs,
      i = 0.obs,
      index = 0.obs,
      questionScore = 0.obs,
      userScores = 0.obs,
      letterBoxWidth = 0.0.obs;

  void addTxt(String txt) {
    i.value++;
    if (i.value <= rightAnswer.length) {
      userAnswer.add(txt);
    }
  }

  void help1() {
    i.value = 1;
    userAnswer.clear();
    userAnswer.add(rightAnswer[0]);
    userScores.value = userScores.value - questionScore.value;
    Get.back();
  }

  void help2() {
    userAnswer.add(rightAnswer[0]);
    userScores.value -= 2 * questionScore.value;
    Get.back();
    Timer(Duration(milliseconds: 1600), () {
      userAnswer.clear();
      index.value++;
      assignVals();
    });
  }

  void skip1() {
    index.value++;
    userScores.value -= questionScore.value * 2;
    assignVals();
    print("skiped");
    Get.back();
    if (index.value < questionList.length - 1) {}
  }

  void skip2() {
    Get.back();
    Timer(Duration(milliseconds: 100), () {
      dialogMsg("👏 تهانينا ", "لقد انهيت جميع المستويات", " ", "خروج",
          mainColor2, () => null, () => exit());
      userScores.value -= questionScore.value * 2;
      print("finished");
    });
  }

  void reset() {
    i.value = 0;
    userAnswer.clear();
  }

  void exit() {
    index.value = 0;
    userScores.value = 0;
    Get.offAll(Home());
  }

  void assignVals() {
    possibleLetters.value =
        questionList[index.value]['possibleLetters'].split(",");
    lastItems.value = possibleLetters.skip(6).take(6).toList();
    rightAnswer.value = questionList[index.value]['answer'];
    answerLength.value = rightAnswer.length;
    letterBoxWidth.value = (Get.width * 0.85) / rightAnswer.length;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
