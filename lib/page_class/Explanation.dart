import 'package:flutter/material.dart';
import 'Explanation_Brain.dart';

ExplanationBrain newExplanation = ExplanationBrain();

class Explanation extends StatefulWidget {
  @override
  _ExplanationState createState() => _ExplanationState();
}

class _ExplanationState extends State<Explanation> {
  int ExplanationNumber = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 12,
              child: Center(
                child: Text(
                  newExplanation.getStory(),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: FlatButton(
                    color: Colors.blue[300],
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
                Expanded(
                  flex: 2,
                  child: FlatButton(
                    color: Colors.red[300],
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
