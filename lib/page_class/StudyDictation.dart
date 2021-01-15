import 'package:flutter/material.dart';

// 단어 문제가 음성으로 출제되고, 받아쓰는 화면
// TODO: 문제풀이 중단 버튼 => 풀다가 종료될 때 버그가 있을까?
// TODO: 받아쓴 글자를 글자 인식 부분에 전달하기
String imgPath = 'images/StudyDictation';

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
            volumeIcon,

            Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //TODO: 첫 문제 이전으로 가기 비활성화, 마지막 문제 다음으로 가기 비활성화
                  children: <Widget>[
                    //이전문제 가기 버튼
                    // TODO: 문제가 없으면 버튼을 숨긴다.
                    passProblem[0],
                    // 받아쓰는 곳
                    //TODO: 그림판 만들기
                    paintDictate,
                    //다음문제 가기 아이콘
                    passProblem[1],
                  ]),
            ),

            //나가기 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [exitButton],
            )
          ],
        ),
      ),
    );
  }
}

Widget exitButton = InkWell(
  child: Image.asset(
    '$imgPath/exit_button.png',
    width: 150,
    height: 100,
  ),
  onTap: () {}, //TODO: 나가기
);
Widget volumeIcon = InkWell(
  child: Image.asset(
    //TODO: 볼륨 아이콘 변경
    '$imgPath/volume.png',
    width: 150,
    height: 70,
  ),
  onTap: () {}, //TODO: 나가기
);

List<Widget> passProblem = [
  InkWell(
    child: Image.asset(
      '$imgPath/prev_problem.png',
      width: 100,
      height: 150,
    ),
    onTap: () {}, //TODO: 이전 문제 불러오기
  ),
  InkWell(
    child: Image.asset(
      '$imgPath/next_problem.png',
      width: 70,
      height: 150,
    ),
    onTap: () {}, //TODO: 다음 문제 불러오기
  ),
];

Widget paintDictate = Container(
  child: CustomPaint(
    size: Size(550, 400), //받아쓸 판 사이즈 조절
    painter:
        DictationPainter._input(p1: new Offset(200, 200), p2: new Offset(0, 0)),
  ),
  decoration: BoxDecoration(
    color: Colors.grey[300],
  ),
);

class DictationPainter extends CustomPainter {
  DictationPainter._input({this.p1, this.p2}) {}
  //선을 그리기 위한 좌표값 TODO: 받아쓰는 좌표 입력 받기
  final Offset p1;
  final Offset p2;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange //TODO: 그림 색깔 지정
      ..strokeCap = StrokeCap.square //선의 끝은 각지게
      ..strokeWidth = 8.0;

    //선을 그린다.
    canvas.drawLine(p1, p2, paint);
  }

  //화면을 새로 그릴지 말지 결정.
  //예전 위젯의 좌표값과 비교해 좌표값이 변했을 때 그린다던디 원하는 조건을 줄 수 있다.
  @override
  bool shouldRepaint(DictationPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(DictationPainter oldDelegate) => false;
}
