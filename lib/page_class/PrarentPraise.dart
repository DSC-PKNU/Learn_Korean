import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/controllor/praise_register_controllor.dart';

class ParentPraise extends StatefulWidget {
  @override
  _ParentPraiseState createState() => _ParentPraiseState();
}

class _ParentPraiseState extends State<ParentPraise> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        //텍스트 필드 외의 화면 다른 곳을 탭하면 키보드가 숨는다.
        //TODO: 뒤로가기 버튼으로 사라지게 할지 결정하자.
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            body: Container(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      '상품 추가',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReusableProduct(stage: 1),
                  ReusableProduct(stage: 2),
                  ReusableProduct(stage: 3),
                  ReusableProduct(stage: 4),
                  ReusableProduct(stage: 5),
                  ReusableProduct(stage: 6),
                  ReusableProduct(stage: 7),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class ReusableProduct extends StatefulWidget {
  ReusableProduct({this.stage}) {
    praiseModel = PraiseModel(praise: '', stage: stage);
  }
  PraiseModel praiseModel;
  final int stage;

  @override
  _ReusableProductState createState() => _ReusableProductState();
}

class _ReusableProductState extends State<ReusableProduct> {
  PraiseRegistControllor praiseRegistControllor = PraiseRegistControllor();

  TextEditingController textEditingControllor = TextEditingController();

  @override
  void initState() {
    praiseRegistControllor.loadSqlite().then((value) {
      widget.praiseModel = value.firstWhere((element) {
        return element.stage == widget.stage;
      });

      textEditingControllor.text = widget.praiseModel.praise;
      setState(() {});
    });

    super.initState();
  }

  @override
  build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 10,
        ),
        Stack(
          children: [
            Image.asset(
              'images/ParentPraise/ParentPraise_background.png',
              width: 100,
              height: 80,
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: Text(
                '${widget.stage}단계',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: 30,
          width: 400,
          child: TextField(
            controller: textEditingControllor,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '',
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            widget.praiseModel.praise = textEditingControllor.text;
            praiseRegistControllor.saveSqlite(widget.praiseModel);
          },
          color: Colors.blue[100],
          child: Text('등록/수정'),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
