import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:learn_korean_for_children/controllor/problem_regist_controllor.dart';
import 'package:learn_korean_for_children/controllor/wrong_problem_controllor.dart';
import 'package:learn_korean_for_children/data/problemData.dart';
import 'package:learn_korean_for_children/library/tts.dart';
import 'package:learn_korean_for_children/model/ProblemModel.dart';
import 'package:painter/painter.dart';
import 'package:collection/collection.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:tesseract_ocr/tesseract_ocr.dart';

// 단어 문제가 음성으로 출제되고, 받아쓰는 화면
String imgPath = 'images/StudyDictation';

class StudyDictation extends StatefulWidget {
  StudyDictation(this.stageIndex, {this.wrongProblemMode = false});
  final int stageIndex;
  final bool wrongProblemMode;
  @override
  _StudyDictationState createState() =>
      _StudyDictationState(this.stageIndex, this.wrongProblemMode);
}

class _StudyDictationState extends State<StudyDictation> {
  @override
  dispose() {
    ttsStop();
    super.dispose();
  }

  _StudyDictationState(this.stageIndex, this.wrongProblemMode);

  final bool wrongProblemMode;
  int stageIndex; //스테이지 번호
  int problemIndex = 0; //문제 번호
  int stageAllocationCount = 10; //각 스테이지에서 10개를 풀 수 있음
  int score = 10; //받아쓰기 점수
  double iconWidth = 150; //하단 버튼 너비
  double iconHeight = 70; //하단 버튼 높이
  String extractText; //OCR 변환 후 텍스트

  File imgFile; //저장할 받아쓰기 이미지
  File pickedImage; //저장한 받아쓰기 이미지

  //문제, 정답여부를 저장한 모델
  List<ProblemModel> problems = [];
  // 받아쓰기 대기열, 받아쓴 후 확인을 누를 때마다 한 글자씩 추가된다.
  List<String> dictationQueue = ['', '', '', '', '', '', '', '', '', ''];

  @override
  void initState() {
    if (wrongProblemMode) {
      //오답노트 모드
      WrongProblemControllor()
        ..loadSqlite(stageIndex).then((value) {
          setState(() {
            problems = value;
            ttsSpeak(problems[problemIndex].problem);
          });
        });
    } else {
      // 커스텀 문제
      if (stageIndex == 0) {
        ProblemRegistControllor()
          ..loadSqlite().then((value) {
            setState(() {
              problems = value;
              ttsSpeak(problems[problemIndex].problem);
            });
          });
      } else {
        // 단계별 문제
        List<String> stageProblemList = problemData[stageIndex];
        stageProblemList.shuffle(); //문제를 섞는다.

        for (int i = 0; i < stageAllocationCount; i++)
          problems.add(ProblemModel(problem: stageProblemList[i]));

        ttsSpeak(problems[problemIndex].problem);
      }
    }
    super.initState();
    //그림판 초기화
    _controller = _newController();
  }

  //그림판 선언
  PainterController _controller;

  //그림판 초기화 함수
  PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.transparent;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return problems.length == 0
        ? SafeArea(
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('저장된 문제가 없습니다.'),
                    RaisedButton(
                      child: Text('뒤로가기'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        : SafeArea(
            child: Container(
              /* 
                      col     col     col
              Row (  문제번호    그     다시듣기     
              .      이전문제    림     다음문제 )

              Row (  아이콘  아이콘  아이콘  아이콘 )
              
              */
              //배경 이미지
              decoration: dictationDeco(),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              children: [
                                //문제번호
                                SizedBox(
                                  height: 150,
                                  width: 100,
                                  child: Text(
                                    '\n\n${problemIndex + 1}번 문제',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                //이전 문제로 가기
                                passProblem()[0],
                              ],
                            ),

                            // 그림판 스택(배경, 대기열, 그림판)
                            Stack(alignment: Alignment.center, children: [
                              Image.asset(
                                "$imgPath/painter.png",
                                width: 400,
                                height: 700,
                              ),
                              // 그림판
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('\n\n\n' + dictationQueue[problemIndex],
                                      style: TextStyle(fontSize: 20)),
                                  paintDictation(),
                                ],
                              ),
                            ]),
                            Column(
                              children: [
                                //다시 듣기 아이콘
                                volumeIcon(),
                                //다음문제 가기 아이콘
                                passProblem()[1],
                              ],
                            ),
                          ]),
                    ),

                    //버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        delButton(),
                        undoButton(),
                        checkButton(),
                        exitButton(context),
                      ],
                    )
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.startTop,
                floatingActionButton: wrongProblemMode
                    ? IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          WrongProblemControllor()
                              .deleteSqlite(stageIndex, problems[problemIndex]);
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  '오답 ${problems[problemIndex].problem} 삭제 완료')));
                        },
                        iconSize: 50,
                      )
                    : SizedBox(),
              ),
            ),
          );
  }

  //폴더에 이미지 저장
  void savePicture(PictureDetails picture) async {
    ui.Image image = await picture.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    imgFile = new File('$directory/screenshot1.png');
    imgFile.writeAsBytes(pngBytes);
  }

  Future<void> savePng(PictureDetails picture) async {
    //이미지 저장
    savePicture(picture);
    //OCR 인식
    extractText = await TesseractOcr.extractText(imgFile.path, language: 'kor');

    setState(() {
      // 받아쓰기 대기열에 추가
      dictationQueue[problemIndex] += extractText;
      print(dictationQueue[problemIndex]);
      // 그림판 초기화
      _controller = _newController();

      // 채점하기
      problems[problemIndex].isRightAnswer = (dictationQueue[problemIndex]
              .compareTo(problems[problemIndex].problem) ==
          0);
    });
  }

  BoxDecoration dictationDeco() => BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(
          "$imgPath/background.png",
        ),
      ));

  BoxDecoration paintDeco() => BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(
          "$imgPath/painter.png",
        ),
      ));

  Widget paintDictation() => Expanded(
      child:
          SizedBox(height: 700, width: 400, child: new Painter(_controller)));

  Widget checkButton() => InkWell(
        child: Image.asset(
          '$imgPath/check.png',
          width: iconWidth,
          height: iconHeight,
        ),
        onTap: () async {
          savePng(_controller.finish());

          print(dictationQueue[problemIndex]);
        },
      );
  Widget delButton() => InkWell(
      child: Image.asset(
        '$imgPath/del.png',
        width: iconWidth,
        height: iconHeight,
      ),
      onTap: _controller.clear);

  Widget undoButton() => InkWell(
        child: Image.asset(
          '$imgPath/undo.png',
          width: iconWidth,
          height: iconHeight,
        ),
        onTap: _controller.undo,
      );

  Widget exitButton(context) => InkWell(
        child: Image.asset(
          '$imgPath/exit.png',
          width: iconWidth,
          height: iconHeight,
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      );
  Widget volumeIcon() => InkWell(
        child: Image.asset(
          '$imgPath/volume.png',
          width: 150,
          height: 150,
        ),
        onTap: () {
          ttsSpeak(problems[problemIndex].problem);
        },
      );

  List<Widget> passProblem() => [
        problemIndex != 0
            ? InkWell(
                child: Image.asset(
                  '$imgPath/prev.png',
                  width: 150,
                  height: 100,
                ),
                onTap: () {
                  setState(() {
                    problemIndex--;
                    _controller = _newController();
                    ttsSpeak(problems[problemIndex].problem);
                  });
                },
              )
            : SizedBox(
                width: 150,
                height: 100,
              ),
        problemIndex != problems.length - 1
            ? InkWell(
                child: Image.asset(
                  '$imgPath/next.png',
                  width: 150,
                  height: 100,
                ),
                onTap: () {
                  setState(() {
                    problemIndex++;
                    _controller = _newController();
                    ttsSpeak(problems[problemIndex].problem);
                  });
                },
              )
            : InkWell(
                child: Image.asset(
                  '$imgPath/next_round.png',
                  width: 150,
                  height: 100,
                ),
                onTap: () {
                  int i = 0;
                  while (i < stageAllocationCount) {
                    if (!problems[problemIndex].isRightAnswer) {
                      WrongProblemControllor()
                          .saveSqlite(stageIndex, problems[problemIndex]);
                      score--;
                    }

                    i++;
                  }
                  Navigator.pop(context);
                },
              ),
      ];
}
