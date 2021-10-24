import 'question.dart';

class FillInBlank extends Question{

  ///Default Constructor
  FillInBlank(stemValue, correctAnswerValue){
    stem = stemValue;
    correctAnswer = correctAnswerValue;
  }

  ///Checks if user answer is in the acceptable list of correct answers.
  evaluateResponse(){
    answerIsCorrect = false;
    for(var answer in correctAnswer){
      if(answer.toString().toLowerCase() == userAnswer.toString().toLowerCase()){
        answerIsCorrect = true;
      }
    }
  }


}