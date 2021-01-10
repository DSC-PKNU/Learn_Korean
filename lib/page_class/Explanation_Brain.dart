import 'ExplanationStory.dart';


class ExplanationBrain {
  int _ExplanationNumber = 0;
  List<ExplanationStory> _storyData = [
    ExplanationStory(
        ExplanationTitle:
        '첫번째 설명',
        choice1: '마지막 설명으로 이동',
        choice2: '두번째 설명으로 이동'),
    ExplanationStory(
        ExplanationTitle: '두번째 설명',
        choice1: '첫번째 설명으로 이동',
        choice2: '세번째 설명으로 이동'),
    ExplanationStory(
        ExplanationTitle:
        '세번째 설명',
        choice1: '두번째 설명으로 이동',
        choice2: '네번째 설명으로 이동'),
    ExplanationStory(
        ExplanationTitle:
        '네번째 설명',
        choice1: '세번째 설명으로 이동',
        choice2: '첫번째 설명으로 이동'),
  ];

  String getStory() {
    return _storyData[_ExplanationNumber].ExplanationTitle;
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
    }
    else {
      return false;
    }
  }

  void nextStory(int choiceNumber) {
    if (_ExplanationNumber == 0 && choiceNumber == 1) {
      _ExplanationNumber = 3;
    }
    else if (_ExplanationNumber == 3 && choiceNumber == 2) {
      _ExplanationNumber = 0;
    }
    else if (choiceNumber == 1) {
      _ExplanationNumber = _ExplanationNumber-1;
    }
    else if (choiceNumber == 2) {
      _ExplanationNumber = _ExplanationNumber+1;
    }
  }
}