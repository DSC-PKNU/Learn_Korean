import 'package:flutter/material.dart';

String imgPath = "images/KidPraise";

class GetPraisePage extends StatefulWidget {
  @override
  _GetPraisePageState createState() => _GetPraisePageState();
}

class _GetPraisePageState extends State<GetPraisePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: praiseBoxDecoration(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          //TODO: 칭찬을 받을 때 마다 나무에 열매가 맺힌다. ,
          body: Container(
            child: PraiseSticker(),
          )),
    ));
  }

  BoxDecoration praiseBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("$imgPath/praise_tree.png"),
        ));
  }
}

// 라운드 갯수만큼 열매 공간 마련
// 획득한 열매만 표시
class PraiseSticker extends StatelessWidget {
  final int totalRound = 20;

  // TODO: 데이터베이스 연결
  // 단계 index 입력받기
  void addSticker(List list, int startIndex, int endIndex) {
    list.add(SizedBox(
      height: 30,
      width: 30,
    ));
    for (int i = 1; i < 1 + endIndex; i++) {
      list.add(InkWell(
          onTap: () {}, //TODO : 칭찬스티커 탭하면 ?
          child: Stack(children: [
            Image.asset(
              '$imgPath/sticker.png',
              width: 40,
              height: 40,
            ),
            Text(
              '${startIndex + i}',
              style: TextStyle(
                fontSize: 15,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = Colors.black,
              ),
            ),
            Text(
              '${startIndex + i}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ])));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> sticker1 = new List<Widget>();
    List<Widget> sticker2 = new List<Widget>();
    List<Widget> sticker3 = new List<Widget>();
    List<Widget> sticker4 = new List<Widget>();

    addSticker(sticker1, 0, 4);
    addSticker(sticker2, 5, 6);
    addSticker(sticker3, 10, 6);
    addSticker(sticker4, 15, 4);

    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: sticker1),
        SizedBox(
          width: 20,
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: sticker2),
        SizedBox(
          width: 20,
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: sticker3,
        ),
        SizedBox(
          width: 20,
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: sticker4,
        ),
        SizedBox(
          width: 45,
          height: 45,
        ),
      ]),
    );
  }
}
