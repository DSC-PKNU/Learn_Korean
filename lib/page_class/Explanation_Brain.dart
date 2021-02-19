import 'ExplanationStory.dart';

const String imagePath = "images/Explanation";

class ExplanationBrain {
  int _ExplanationNumber = 0;
  List<ExplanationStory> _storyData = [
    ExplanationStory(
        explainImgPath: '$imagePath/story1.png',
        choice1: '마지막 설명으로 이동',
        choice2: '두번째 설명으로 이동'),
    ExplanationStory(
        explainImgPath: '$imagePath/story2.png',
        choice1: '첫번째 설명으로 이동',
        choice2: '세번째 설명으로 이동'),
    ExplanationStory(
        explainImgPath: '$imagePath/story3.png',
        choice1: '두번째 설명으로 이동',
        choice2: '네번째 설명으로 이동'),
    ExplanationStory(
        explainImgPath: '$imagePath/story4.png',
        choice1: '세번째 설명으로 이동',
        choice2: '첫번째 설명으로 이동'),
  ];

  String getStory() {
    return _storyData[_ExplanationNumber].explainImgPath;
  }

  String getChoice1() {
    return _storyData[_ExplanationNumber].choice1;
  }

  String getChoice2() {
    return _storyData[_ExplanationNumber].choice2;
  }

  void restart() {
    _ExplanationNumber = 0;
  }

  bool buttonShouldBeVisible() {
    if (_ExplanationNumber < 3) {
      return true;
    } else {
      return false;
    }
  }

  void nextStory(int choiceNumber) {
    if (_ExplanationNumber == 0 && choiceNumber == 1) {
      _ExplanationNumber = 3;
    } else if (_ExplanationNumber == 3 && choiceNumber == 2) {
      _ExplanationNumber = 0;
    } else if (choiceNumber == 1) {
      _ExplanationNumber = _ExplanationNumber - 1;
    } else if (choiceNumber == 2) {
      _ExplanationNumber = _ExplanationNumber + 1;
    }
  }
}
