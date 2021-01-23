import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/controllor/problem_regist_controllor.dart';
import 'package:learn_korean_for_children/controllor/wrong_problem_controllor.dart';
import 'package:learn_korean_for_children/data/problemData.dart';
import 'package:learn_korean_for_children/library/tts.dart';
import 'package:learn_korean_for_children/model/ProblemModel.dart';
import 'package:painter/painter.dart';
import 'dart:typed_data';

// 단어 문제가 음성으로 출제되고, 받아쓰는 화면
// TODO: 문제풀이 중단 버튼 => 풀다가 종료될 때 버그가 있을까?
// TODO: 받아쓴 글자를 글자 인식 부분에 전달하기
//TODO: 충돌을 수정한 부분에서 문제가 없는지 확인하자.
//TODO: ScaffoldMessnger 버전문제 해결하자
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
  int stageIndex;
  int problemIndex = 0;
  int stageAllocationCount = 10; //각 스테이지에서 10개를 풀 수 있음
  List<ProblemModel> problems = [];



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
      if (stageIndex == 0) {
        ProblemRegistControllor()
          ..loadSqlite().then((value) {
            setState(() {
              problems = value;
              ttsSpeak(problems[problemIndex].problem);
            });
          });
      } else {
        List<String> stageProblemList = problemData[stageIndex];
        stageProblemList.shuffle(); //문제를 섞는다.

        for (int i = 0; i < stageAllocationCount; i++) {
          problems.add(ProblemModel(problem: stageProblemList[i]));
        }
        ttsSpeak(problems[problemIndex].problem);
      }
    }
    super.initState();
    //그림판 설정=============================================
    _controller = _newController();
  }
  //그림판을 위한 변수
  PainterController _controller;

  PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.grey[300];
    return controller;
  }

  //그림판=================================

  @override
  Widget build(BuildContext context) {
      // List<Widget>actions = [
      //   //지우기
      //   new IconButton(
      //       icon: new Icon(Icons.delete),
      //       tooltip: 'Clear',
      //       onPressed: _controller.clear),
      // ];
    

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
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(child: Text('${problemIndex + 1}번 문제')),
                  volumeIcon(),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        passProblem()[0],

                        // 받아쓰는 곳
                        SizedBox(
                          height: 200,
                          width: 400,
                          child:Painter(_controller)
                        ),
                        //FIXME: 임시로 만들어둔 버튼
                        // Row(
                        //   children: [
                        //     RaisedButton(
                        //       child: Text('정답'),
                        //       onPressed: () {
                        //         // ScaffoldMessenger.of(context)
                        //         //     .showSnackBar(SnackBar(
                        //         //   content: Text('정답'),
                        //         // ));
                        //       },
                        //     ),
                        //     RaisedButton(
                        //       child: Text('오답'),
                        //       onPressed: () {
                        //         WrongProblemControllor().saveSqlite(
                        //             stageIndex, problems[problemIndex]);
                        //         // ScaffoldMessenger.of(context)
                        //         //     .showSnackBar(SnackBar(
                        //         //   content: Text(
                        //         //       '오답 ${problems[problemIndex].problem} 문제'),
                        //         // ));
                        //       },
                        //     )
                        //   ],
                        // ),
                        //다음문제 가기 아이콘
                        passProblem()[1],
                      ]),

                  //나가기 버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text(
                        //       '오답 ${problems[problemIndex].problem} 삭제 완료'),
                        // ));
                      },
                      iconSize: 50,
                    )
                  : SizedBox(),
            ),
          );

  }

  Widget exitButton(context) => InkWell(
        child: Image.asset(
          '$imgPath/exit_button.png',
          width: 150,
          height: 50,
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      );
  Widget volumeIcon() => InkWell(
        child: Image.asset(
          '$imgPath/volume.png',
          width: 150,
          height: 70,
        ),
        onTap: () {
          ttsSpeak(problems[problemIndex].problem);
        },
      );







  List<Widget> passProblem() => [
        problemIndex != 0
            ? InkWell(
                child: Image.asset(
                  '$imgPath/prev_problem.png',
                  width: 200,
                  height: 200,
                ),
                onTap: () {
                  setState(() {
                    problemIndex--;

                    ttsSpeak(problems[problemIndex].problem);
                  });
                },
              )
            : SizedBox(
                width: 200,
                height: 200,
              ),
        problemIndex != problems.length - 1
            ? InkWell(
                child: Image.asset(
                  '$imgPath/next_problem.png',
                  width: 150,
                  height: 150,
                ),
                onTap: () {
                  setState(() {
                    problemIndex++;

                    ttsSpeak(problems[problemIndex].problem);
                  });
                },
              )
            : RaisedButton(
                child: Text('StageClear!'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
      ];
}
