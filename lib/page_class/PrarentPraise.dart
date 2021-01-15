import 'package:flutter/material.dart';

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
                  ReusableProduct(text: '1단계'),
                  ReusableProduct(text: '2단계'),
                  ReusableProduct(text: '3단계'),
                  ReusableProduct(text: '4단계'),
                  ReusableProduct(text: '5단계'),
                  ReusableProduct(text: '6단계'),
                  ReusableProduct(text: '7단계'),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class ReusableProduct extends StatelessWidget {
  ReusableProduct({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
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
                '$text',
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
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'input',
            ),
          ),
        ),
        FlatButton(
          onPressed: () {},
          color: Colors.blue[100],
          child: Text('상품 관리'),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
