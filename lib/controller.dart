import 'package:get/get.dart';

class QuestionController extends GetxController {
  var userAnswer = [].obs,
      rightAnswer = ["ط", "ا", "ئ", "ر"].obs,
      possibleLetters =
          ["ن", "ا", "ط", "و", "ا", "س", "ن", "ا", "ر", "ة", "ك", "ئ"].obs,
      firstLetterOfAnswer = "ط".obs,
      i = 0.obs,
      currentIndex = 0.obs,
      questionScore = 20.obs,
      userScores = 20.obs;

  void addTxt(String txt) {
    i.value++;
    if (i.value <= rightAnswer.length) {
      userAnswer.add(txt);
    }
  }

  void help() {
    i.value = 1;
    userAnswer.clear();
    userScores.value = userScores.value - questionScore.value;
    userAnswer.add(firstLetterOfAnswer.value);
    Get.back();
  }

  void skip() {
    userScores.value = userScores.value - questionScore.value * 2;
    currentIndex.value++;
    Get.back();
    reset();
  }

  void reset() {
    i.value = 0;
    userAnswer.clear();
  }
}
