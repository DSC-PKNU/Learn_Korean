import 'package:flutter/material.dart';

// 단어 문제가 음성으로 출제되고, 받아쓰는 화면
// TODO: 문제풀이 중단 버튼 => 풀다가 종료될 때 버그가 있을까?
// TODO: 받아쓴 글자를 글자 인식 부분에 전달하기
String img_path = 'images/StudyDictation';

class StudyDictation extends StatefulWidget {
  @override
  _StudyDictationState createState() => _StudyDictationState();
}

class _StudyDictationState extends State<StudyDictation> {
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

                  // 받아쓰는 곳
                  //TODO: 그림판 만들기
                  Text('받아쓰기받아쓰기'),

                  //다음문제 가기 아이콘
                  PassProblem[1],
                ]),

            //나가기 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ExitButton,
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget ExitButton = InkWell(
  child: Image.asset(
    '$img_path/exit_button.png',
    width: 150,
    height: 100,
  ),
  onTap: () {}, //TODO: 나가기
);
Widget VolumeIcon = InkWell(
  child: Image.asset(
    //TODO: 볼륨 아이콘 변경
    '$img_path/volume.png',
    width: 150,
    height: 70,
  ),
  onTap: () {}, //TODO: 나가기
);

// Widget PaintDictation = ; //TODO: 받아쓸 그림판
List<Widget> PassProblem = [
  InkWell(
    child: Image.asset(
      '$img_path/prev_problem.png',
      width: 200,
      height: 200,
    ),
    onTap: () {}, //TODO: 이전 문제 불러오기
  ),
  InkWell(
    child: Image.asset(
      '$img_path/next_problem.png',
      width: 150,
      height: 150,
    ),
    onTap: () {}, //TODO: 다음 문제 불러오기
  ),
];
