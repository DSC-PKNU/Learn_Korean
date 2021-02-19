import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_korean_for_children/page_class/IncorrectProblem.dart';
import 'Explanation_Brain.dart';

ExplanationBrain newExplanation = ExplanationBrain();

class Explanation extends StatefulWidget {
  @override
  _ExplanationState createState() => _ExplanationState();
}

class _ExplanationState extends State<Explanation> {
  int ExplanationNumber = 0;

  Widget backPage(BuildContext context) {
    return InkWell(
        child: Image.asset('images/IncorrectProblem/back_page_blue.png',
            width: 120, height: 120),
        onTap: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
              children: [
                Expanded(
                  flex: 12,
                  child: Center(
                      child: Image(
                        image: AssetImage(newExplanation.getStory()),
                      )
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FlatButton(
                          child: Text(
                            newExplanation.getChoice1(),
                          ),
                          onPressed: () {
                            setState(() {
                              newExplanation.nextStory(1);
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FlatButton(
                          child: Text(
                            newExplanation.getChoice2(),
                          ),
                          onPressed: () {
                            setState(() {
                              newExplanation.nextStory(2);
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 30,),
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          ]
        ),
      ),
    );
  }
}
