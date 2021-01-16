//맞춤법 심화 학습

import 'package:flutter/material.dart';

// 맞춤법 문제가 음성으로 출제되고, 고르는 화면
// TODO: 문제풀이 중단 버튼 => 풀다가 종료될 때 버그가 있을까?
// TODO: 맞춤법 선택한 답을 백엔드에 전달하기
String imgPath = 'images/Othography';

class Orthography extends StatefulWidget {
  @override
  _OrthographyState createState() => _OrthographyState();
}

class _OrthographyState extends State<Orthography> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //볼륨조절 아이콘
            VolumeIcon,

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //TODO: 첫 문제 이전으로 가기 비활성화, 마지막 문제 다음으로 가기 비활성화
                children: <Widget>[
                  //이전문제 가기 버튼
                  // TODO: 문제가 없으면 버튼을 숨긴다.
                  PassProblem[0],

                  //TODO: 맞춤법 양자택일 문제 출제
                  Column(
                    children: [
                      //그림
                      Question,
                      Row(
                        children: [
                          SelectAns[0],
                          SizedBox(width: 100),
                          SelectAns[1]
                        ],
                      ),
                    ],
                  ),
                  //다음문제 가기 아이콘
                  PassProblem[1],
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
}

Widget exitButton(context) => InkWell(
      child: Image.asset(
        '$imgPath/exit_button.png',
        width: 150,
        height: 100,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
Widget VolumeIcon = InkWell(
  child: Image.asset(
    //TODO: 볼륨 아이콘 변경
    '$imgPath/volume.png',
    width: 150,
    height: 70,
  ),
  onTap: () {}, //TODO: 나가기
);

// Widget PaintDictation = ; //TODO: 받아쓸 그림판
List<Widget> PassProblem = [
  InkWell(
    child: Image.asset(
      '$imgPath/prev_problem.png',
      width: 200,
      height: 200,
    ),
    onTap: () {}, //TODO: 이전 문제 불러오기
  ),
  InkWell(
    child: Image.asset(
      '$imgPath/next_problem.png',
      width: 150,
      height: 150,
    ),
    onTap: () {}, //TODO: 다음 문제 불러오기
  ),
];
Widget Question = Image.asset(
  '$imgPath/sand.png',
  width: 100,
  height: 100,
);
List<Widget> SelectAns = [
  Text(
    '모래',
    style: TextStyle(fontSize: 30),
  ),
  Text(
    '모레',
    style: TextStyle(fontSize: 30),
  )
];
