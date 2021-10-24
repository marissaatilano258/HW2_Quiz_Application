import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_hw2_application/Model/fill_in_blank.dart';
import 'package:quiz_hw2_application/Model/multiple_choice.dart';
import 'package:quiz_hw2_application/Model/question.dart';
import 'package:quiz_hw2_application/Model/quiz.dart';

List<Question> _poolOfQuestions = [];

getQuiz(quizNum) async{
  const _quizWebService = 'http://www.cs.utep.edu/cheon/cs4381/homework/quiz?quiz=';
  var quizName = 'quiz';
  if(quizNum < 10){
    quizName += '0' + quizNum.toString();
  } else {
    quizName += quizNum.toString();
  }
  var response = await http.get(Uri.parse(_quizWebService + quizName));
  return response.body;
}

populatePoolOfQuestions() async {
  var quizNum = 1;
  var quizAvailable = true;
  while(quizAvailable){
    var currQuiz = await getQuiz(quizNum);
    var parsedQuiz = parseQuiz(currQuiz);
    if(parsedQuiz['response']) {
      addQuizToPool(parsedQuiz);
    }
    quizNum++;
    quizAvailable = parsedQuiz['response'];
  }
}

///Adds contents of a single quiz to the pool.
addQuizToPool(parsedQuiz){
  for (var j = 0; j < parsedQuiz['quiz']['question'].length; j++) {
    var question = parseQuestion(parsedQuiz['quiz']['question'][j]);
    _poolOfQuestions.add(question);
  }
}

///Parses the quiz from JSON.
parseQuiz(quizToParse){
  return json.decode(quizToParse);
}

///Parses the question from JSON and creates Question object based on parsed data.
parseQuestion(question){
  var newQuestion;
  var stem = question['stem'];
  var answer = question['answer'];
  if(question['type']==1){
    newQuestion = MultipleChoice(stem, question['option'], answer);
  } else{
    List<String> setOfAnswers = new List<String>.from(answer);
    newQuestion = FillInBlank(stem, setOfAnswers);
  }
  return newQuestion;
}

createRandomizedQuiz(numRequested){
  _poolOfQuestions.shuffle();
  var randomQuestions = [];
  for(var i = 0; i < numRequested; i++){
    randomQuestions.add(_poolOfQuestions[i]);
  }
  var newQuiz = Quiz(randomQuestions);
  return newQuiz;
}

formatCorrectAnswer(question){
  if(question is MultipleChoice){
    return question.options[question.correctAnswer-1];
  } else{
    return question.correctAnswer;
  }
}

gradeQuiz(quiz){
  var correctQuestions = 0;
  for(var question in quiz.questions){
    question.evaluateResponse();
    if (question.answerIsCorrect) {
      correctQuestions++;
      print('it is correct');
    }
  }
  quiz.totalCorrectAnswers = correctQuestions;
  return quiz;
}