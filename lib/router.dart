import 'package:flutter/material.dart';
import 'View/create_quiz.dart';
import 'View/grade_answers.dart';
import 'View/review_questions.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case '/':
      return MaterialPageRoute(builder: (context) => CreateQuiz());
    case 'grade_answers':
      var argument = settings.arguments;
      return MaterialPageRoute(builder: (context) => GradeAnswers(argument:argument));
    case 'review_questions':
      var argument = settings.arguments;
      return MaterialPageRoute(builder: (context) => ReviewQuestions(argument:argument));
    default:
      return MaterialPageRoute(builder: (context) => CreateQuiz());
  }
}