//맞춤법 심화 학습

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/controllor/problem_orthography.dart';
import 'package:learn_korean_for_children/data/orthographyData.dart';
import 'package:learn_korean_for_children/model/OrthographyModel.dart';
import 'package:learn_korean_for_children/page_class/IncorrectProblem.dart';

// 맞춤법 문제가 음성으로 출제되고, 고르는 화면
// TODO: 문제풀이 중단 버튼 => 풀다가 종료될 때 버그가 있을까?
// TODO: 맞춤법 선택한 답을 백엔드에 전달하기
String imgPath = 'images/Orthography';

class Orthography extends StatefulWidget {
  @override
  _OrthographyState createState() => _OrthographyState();
}

class _OrthographyState extends State<Orthography> {
  int problemIndex = 0;
  int stageAllocationCount = 10;
  List<OrthographyModel> problems = [];
  List<OrthographyModel> incorrectProblems = [];
  List<List<String>> stageProblemList = [];

  @override
  void initState() {
    //문제를 모두 불러온다.
    for (int i = 1; i < 20; i++) {
      stageProblemList.add(orthographyData[i]);
    }
    stageProblemList.shuffle(); //문제를 섞는다.

    for (int i = 0; i < stageAllocationCount; i++) {
      problems.add(OrthographyModel(problem: stageProblemList[i][0]));
      incorrectProblems.add(OrthographyModel(problem: stageProblemList[i][1]));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: [
                        //그림
                        Text('${problemIndex + 1}번 문제'),
                        question,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            selectAns()[0],
                            SizedBox(width: 60),
                            selectAns()[1]
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),

            //나가기 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [exitButton(context)],
            )
          ],
        ),
      ),
    );
  }

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

  List<Widget> selectAns() => [
        Material(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(300),
          child: InkWell(
            borderRadius: BorderRadius.circular(300),
            onTap: () {
              setState(() {
                problemIndex++;
              });
            }, //TODO: 채점
            child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(children: [
                Text(
                  '\n    ' + problems[problemIndex].problem,
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '\n    ' + problems[problemIndex].problem,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ),
        ),
        Material(
          color: Colors.green,
          borderRadius: BorderRadius.circular(300),
          child: InkWell(
            borderRadius: BorderRadius.circular(300),
            onTap: () {
              setState(() {
                problemIndex++;
              });
            }, //TODO: 채점
            child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(children: [
                Text(
                  '\n    ' + incorrectProblems[problemIndex].problem,
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '\n    ' + incorrectProblems[problemIndex].problem,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ),
        ),
      ];
}

Widget exitButton(context) => InkWell(
    child: Image.asset(
      '$imgPath/exit_button.png',
      width: 150,
      height: 100,
    ),
    onTap: () => Navigator.pop(context));

Widget question = Image.asset(
  '$imgPath/sand.png',
  width: 100,
  height: 100,
);
