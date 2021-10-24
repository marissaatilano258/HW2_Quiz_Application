class Question{
  ///Problem statement of the question.
  var _stem;
  ///Acceptable answer of the stem.
  var _correctAnswer;
  ///Answer input by user for the stem.
  var _userAnswer;
  ///States whether user answer is a correct answer.
  var _answerIsCorrect;

  ///Checks if user answer is the correct answers.
  evaluateResponse(){
    _answerIsCorrect = _userAnswer == _correctAnswer;
  }

  get stem => _stem;

  get correctAnswer => _correctAnswer;

  get userAnswer => _userAnswer;

  get answerIsCorrect => _answerIsCorrect;

  set stem(value) {
    _stem = value;
  }

  set correctAnswer(value) {
    _correctAnswer = value;
  }

  set userAnswer(value) {
    _userAnswer = value;
  }

  set answerIsCorrect(value) {
    _answerIsCorrect = value;
  }
}