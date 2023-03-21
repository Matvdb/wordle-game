import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordle/outils/wordle.dart';

class GameBoard extends StatefulWidget {
  GameBoard(this.game, {Key? key}) : super(key: key);
  WordleGame game;

  @override
  State<GameBoard> createState() => GameBoardState();
}

class GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.game.wordleBoard
      .map((e) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, 
          children: e.map((e) => Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.09,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: e.code == 0 
                ? Colors.grey.shade400
                : e.code == 1 
                  ?Colors.green 
                  : Colors.amber,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text("${e.letter}", style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),),
            ) 
          )).toList(),
        ),
      ).toList(),
    );
  }
}