import 'package:flutter/material.dart';
import 'package:quiz_hw2_application/Controller/quiz_controller.dart';

class ReviewQuestions extends StatefulWidget {
  var argument;
  ReviewQuestions({Key? key, required this.argument}) : super(key:key);

  @override
  _ReviewQuestions createState() => _ReviewQuestions();
}

class _ReviewQuestions extends State<ReviewQuestions> {
  int _currQuestionNum = -1;
  int _currentIndex = 0;

  @override
  initState(){
    incrementQuestionNum();
  }

  incrementQuestionNum(){
    for(int i = _currQuestionNum + 1; i < widget.argument.questions.length; i++){
      if(!widget.argument.questions[i].answerIsCorrect){
        _currQuestionNum = i;
        return;
      }
    }
  }

  decrementQuestionNum(){
    for(int i = _currQuestionNum - 1; i >= 0; i--){
      if(!widget.argument.questions[i].answerIsCorrect){
        _currQuestionNum = i;
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Question ' + (_currQuestionNum+1).toString(),
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    ),
                    Text((_currQuestionNum+1).toString() + ' < ' +
                        (widget.argument.questions.length).toString() +
                        ' > 0'),
                  ]
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                Text(widget.argument.questions[_currQuestionNum].stem,
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  //key: _numQuestionsFormFieldKey,
                  initialValue: 'pretend answer',
                  decoration: const InputDecoration(
                    labelText: 'Answer:',
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 30.0)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  color: Colors.green.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Row(
                        children: <Widget>[
                          const Padding(padding: EdgeInsets.only(left: 5.0)),
                          Text(formatCorrectAnswer(widget.argument.questions[_currQuestionNum]).toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.black),
                            )
                        ]
                      ),
                    ]
                  )
                )
              ]
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_ios),
            label: 'Previous',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bug_report),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward_ios),
            label: 'Next',
          ),
        ],
        onTap: (index){
          setState((){
            _currentIndex = index;
            switch(index){
              case 0: decrementQuestionNum();
                break;
              case 2: incrementQuestionNum();
                break;
              default:
                break;
            }
          });
        },
      )
    );
  }
}