import 'package:flutter/material.dart';

// 단어 문제가 음성으로 출제되고, 받아쓰는 화면
// TODO: 문제풀이 중단 버튼 => 풀다가 종료될 때 버그가 있을까?
// TODO: 받아쓴 글자를 글자 인식 부분에 전달하기

class StudyDictation extends StatefulWidget {
  @override
  _StudyDictationState createState() => _StudyDictationState();
}

class _StudyDictationState extends State<StudyDictation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //[여기에써주세요] 텍스트, 볼륨 아이콘 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('여기에 써주세요'), //TODO: 텍스트박스 디자인 변경
              VolumeIcon
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //TODO: 첫 문제 이전으로 가기 비활성화, 마지막 문제 다음으로 가기 비활성화
            children: <Widget>[
              //이전문제 가기 아이콘
              PassProblem[0],

              // 받아쓰는 곳
              //TODO: 그림판 만들기
              Text('받아쓰기받아쓰기'),
              
              //다음문제 가기 아이콘
              PassProblem[1],

            ]
          ),

          //여백
          SizedBox(
            height:50.0
          ),

          //나가기 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ExitButton,
              SizedBox(width:100)
            ],
          )

        ],
      ),
    );
  }
}
Widget ExitButton = IconButton(    
  icon: Icon(
    Icons.exit_to_app
    )
  );
Widget VolumeIcon = 
  IconButton(
    icon: Icon(
      Icons.volume_up,
    ), 
    onPressed: null//TODO: 볼륨 조절기능
  );

// Widget PaintDictation = ; //받아쓸 그림판
List<Widget> PassProblem = [
  IconButton(
            icon: Icon(
                Icons.arrow_back_ios,
                size: 70.0,
              ),
            onPressed: (){
              //이전 문제로 돌아가기
            },
          ),

  IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 70.0,
            ), 
            onPressed: (){
              //TODO: 다음 문제 불러오기
            }
          ),
];