import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;

  Result(this.resultScore);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Text(
         "your result is "+resultScore.toString(),
          textAlign: TextAlign.center,style:TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
