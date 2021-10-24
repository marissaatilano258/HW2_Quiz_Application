import 'package:flutter/material.dart';
import 'package:quiz_hw2_application/Controller/quiz_controller.dart';


class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuiz createState() => _CreateQuiz();
}

class _CreateQuiz extends State<CreateQuiz> {
  int visible = 0;

  final GlobalKey<FormFieldState<String>> _numQuestionsFormFieldKey = GlobalKey();

  _notEmpty(String value) => value.isNotEmpty;

  get values => ({
    'numQuestions': _numQuestionsFormFieldKey.currentState?.value,
  });

  getQuizData(visible) async {
    if(visible >= 1) {
      await populatePoolOfQuestions();
      var quiz = createRandomizedQuiz(int.parse(values['numQuestions']));
      return Navigator.pushNamed(context, 'grade_answers', arguments: quiz);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Quiz'),
      ),
      body: Form(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child:Center(
            child:Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                const Text('Welcome to the',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                const Text('Quiz App',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                const Padding(padding: EdgeInsets.only(top: 30.0)),
                const Text('Enter the number of questions for this quiz:',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  key: _numQuestionsFormFieldKey,
                  decoration: const InputDecoration(
                    labelText: 'Number of Questions',
                  ),
                  validator: (value) =>
                  _notEmpty(value!) ? null : 'Number of Questions is required',
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Builder(builder: (context) {
                  return Row(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        child: const Text('Start Quiz'),
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
                        onPressed: () async {
                          if (Form.of(context)!.validate()) {
                            setState(() {
                              visible++;
                            });
                          }
                        },
                      ),
                    ),
                  ]
                  );
                }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                ),
                LoadQuiz(getQuizData(visible), visible),
              ]
            )
          )
        )
      ),
    );
  }
}

class LoadQuiz extends StatelessWidget {
  final int vi;
  var quiz;

  LoadQuiz(this.quiz, this.vi);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: quiz,
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Padding(padding: EdgeInsets.symmetric(vertical: 0.0));
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return snapshot.data;
              } else {
                return const Padding(padding: EdgeInsets.symmetric(vertical: 0.0));
              }
          }
        },
      ),
    );
  }
}

