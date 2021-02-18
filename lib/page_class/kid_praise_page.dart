import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/controllor/praise_register_controllor.dart';

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
  final Future<List> praise = PraiseRegistControllor().loadSqlite();

  Dialog showPraise() => Dialog(
        child: Text('획득한 상품'),
      );

  Widget backPage(BuildContext context) {
    return InkWell(
        child: Image.asset('images/IncorrectProblem/back_page_blue.png',
            width: 120, height: 120),
        onTap: () {
          Navigator.pop(context);
        });
  }

  void addSticker(
      List list, int startIndex, int endIndex, BuildContext context) {
    list.add(SizedBox(
      height: 30,
      width: 30,
    ));
    for (int i = 1; i <= endIndex; i++) {
      list.add(InkWell(
          onTap: () {
            showDialog(context: context, builder: (context) => showPraise());
          },
          child: Stack(children: [
            //상품을 획득한 경우 스티커, 아니면 사이즈박스
            PraiseRegistControllor().loadEachSqlite(i) != null
                ? Image.asset(
                    '$imgPath/sticker.png',
                    width: 40,
                    height: 40,
                  )
                : SizedBox(
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

    addSticker(sticker1, 0, 4, context);
    addSticker(sticker2, 4, 6, context);
    addSticker(sticker3, 10, 6, context);
    addSticker(sticker4, 16, 4, context);

    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              backPage(context),
              SizedBox(
                height: 200,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: sticker1,
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: sticker2,
              ),
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
            ],
          ),
        ],
      ),
    );
  }
}
