import 'question.dart';

class MultipleChoice extends Question{
  ///List of multiple choice options.
  var _options = [];

  ///Default Constructor
  MultipleChoice(stemValue, optionsValue, correctAnswerValue){
    stem = stemValue;
    _options = optionsValue;
    correctAnswer = correctAnswerValue;
  }

  ///Named constructor for True or False Multiple Choice Questions.
  MultipleChoice.trueOrFalse(stemValue, correctAnswerValue){
    stem = stemValue;
    _options = ['True', 'False'];
    correctAnswer = correctAnswerValue;
  }

  get options => _options;

  set options(value) {
    _options = value;
  }

}