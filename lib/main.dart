import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/quiz.dart';
import 'widgets/result.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool firsTime = true;
  final TextEditingController  nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
   }


  final _questions =  [
    {
      'questionText': 'What is the capital of Egypt',
      'answers': [
        {'text': 'Cairo', 'score': 10},
        {'text': 'Tripoli', 'score': 0},
        {'text': 'Mansoura', 'score': 0},
        {'text': 'Banha', 'score': 0},
      ],
    },
    {
      'questionText': 'which team mohammed salah playing?',
      'answers': [
        {'text': 'barcelona', 'score': 0},
        {'text': 'madrid', 'score': 0},
        {'text': 'liverpol', 'score': 10},
        {'text': 'arsenal', 'score': 0},
      ],
    },
    {
      'questionText': 'who is the last team won champions leage',
      'answers': [
        {'text': 'liverpool', 'score': 0},
        {'text': 'arsenal', 'score': 0},
        {'text': 'PSG', 'score': 0},
        {'text': 'payren munchen', 'score': 10},
      ],
    },
    {
      'questionText': 'where is burj Khalifa',
      'answers': [
        {'text': 'UAE', 'score': 10},
        {'text': 'egypt', 'score': 0},
        {'text': 'france', 'score': 0},
        {'text': 'saudia', 'score': 0},
      ],
    },
    {
      'questionText': 'what is Xiaomi',
      'answers': [
        {'text': 'car', 'score': 0},
        {'text': 'mobile', 'score': 10},
        {'text': 'town', 'score': 0},
        {'text': 'person', 'score': 0},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _answerQuestion(int score) {
    // var aBool = true;
    // aBool = false;

    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (firsTime == true) {
      return MaterialApp(
        home: Scaffold(
          body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(

                    controller: nameController,
                    decoration:  InputDecoration(
                      hintText: 'please enter your name',
                      labelText: 'Name *',
                    ),

                  ),
                ),
              ),
              FlatButton(
                  child: Text("Enter"),
                  color: Colors.pink,
                  onPressed: ()async {

// to save user name and share it across screens
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('userName', nameController.text);

                    setState(() {
                      firsTime=false;
                    });
                    Navigator.push(

                        context,
                        MaterialPageRoute(
                            builder: (context) => Quiz(
                                  answerQuestion: _answerQuestion,
                                  questionIndex: _questionIndex,
                                  questions: _questions,
                                )),
                      );})
            ],
          )),
        ),
      );
    } else {

      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Quiz App'),
          ),
          body: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions:_questions,
                )
              : Result(
                  _totalScore,
                ),
        ),
      );
    }
  }
// use this function to generate random questions
  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {

      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

}
