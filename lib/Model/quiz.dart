class Quiz {
  ///List of questions for this quiz.
  var _questions = [];
  ///Value of total questions answered correctly by the user.
  var _totalCorrectAnswers;

  ///Default Constructor
  Quiz(questions) {
    _questions = questions;
    _totalCorrectAnswers = 0;
  }

  get questions => _questions;

  get totalCorrectAnswers => _totalCorrectAnswers;

  set questions(value) {
    _questions = value;
  }

  set totalCorrectAnswers(value) {
    _totalCorrectAnswers = value;
  }
}

