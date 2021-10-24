import 'package:flutter/material.dart';
import 'package:quiz_hw2_application/Controller/quiz_controller.dart';

class GradeAnswers extends StatefulWidget {
  var argument;
  GradeAnswers({Key? key, required this.argument}) : super(key:key);

  @override
  _GradeAnswers createState() => _GradeAnswers();
}

class _GradeAnswers extends State<GradeAnswers> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child:Center(
          child:Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 40.0)),
                const Text('You earned a score of',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87),
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                Text(
                  gradeQuiz(widget.argument).totalCorrectAnswers.toString(),
                  style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                Text('out of ' + widget.argument.questions.length.toString() + ' points.',
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87),
                ),
                const Padding(padding: EdgeInsets.only(top: 40.0)),
                ReviewPrompt(argument: widget.argument,),
              ]
          ),
        ),
      ),
    );
  }
}

class ReviewPrompt extends StatelessWidget{
  var argument;
  ReviewPrompt({Key? key, required this.argument}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Column(
        children: <Widget>[
          const Text('Tap the Review button below to review the questions that were answered incorrectly.',
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black87),
          ),
          const Padding(padding: EdgeInsets.only(top: 40.0)),
          Builder(builder: (context) {
            return Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  child: const Text('Review'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )
                      )
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'review_questions', arguments: argument);
                  },
                ),
              ),
            ]
            );
          },)
        ]
    );
  }
}