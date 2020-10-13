import 'package:flutter/material.dart';
import 'question.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizbrain = new QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List <Icon> scoreKeeper = [];
  // List <String> questionSet = ['You can lead a cow down stairs but not up stairs.','Approximately one quarter of human bones are in the feet.','A slug\'s blood is green.'];
   //int questionNumber = 0;
  // List <bool> answers = [false,true,true];
  //
  // Question q1 = (q:'You can lead a cow down stairs but not up stairs.',a:false);

void rightWrong(bool check) {
  bool correct = quizbrain.getQuestionAnswer();
  setState(() {
    if (quizbrain.isFinished() == true) {
      Alert(context: context, title: "Thank you", desc: "Flutter is awesome.",
          buttons: [
            DialogButton(
              child: Text("Cool"), onPressed: () => Navigator.pop(context),
              width: 120,)
          ]).show();

      quizbrain.reset();
      scoreKeeper.clear();
    }
    else {
      if (check == correct) {
        print('User got it right');
        scoreKeeper.add(Icon(Icons.check, color: Colors.green));
      } else {
        print('User got it wrong');
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }
      quizbrain.nextQuestion();
    }
  });
}
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                  rightWrong(true);
                //The user picked true
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                rightWrong(false);
                //The user picked false.
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper
        )
        //TODO: Add a Row here as your score keeper
  ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
