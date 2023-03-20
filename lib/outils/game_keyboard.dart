import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordle/outils/game_board.dart';
import 'package:wordle/outils/wordle.dart';

class GameKeyboard extends StatefulWidget {
  GameKeyboard(this.game, {Key? key}) : super(key: key);
  WordleGame game;

  @override
  State<GameKeyboard> createState() => _GameKeyboardState();
}

class _GameKeyboardState extends State<GameKeyboard> {
  List row1 = "AZERTYUIOP".split("");
  List row2 = "QSDFGHJKLM".split("");
  List row3 = ["SUP", "W", "X", "C", "V", "B", "N", "ENTRÉE"];

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(WordleGame.msgGame),
        SizedBox(
          height: 20.0,
        ),
        GameBoard(widget.game),
        SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row1.map((e) {
            return InkWell(
              onTap: (){
                print(e);
                if(widget.game.letterId < 5){
                  setState(() {
                    widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                    widget.game.letterId++;
                  });
                }
              },
              child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Text("${e}"),
            ));
          }).toList(),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row2.map((e) {
            return InkWell(
              onTap: (){
                print(e);
                // logic
                if(widget.game.letterId < 5){
                  setState(() {
                    widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                    widget.game.letterId++;
                  });
                }
              },
              child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Text("${e}"),
            ));
          }).toList(),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row3.map((e) {
            return InkWell(
              onTap: (){
                print(e);
                if(e == "SUP"){
                    if(widget.game.letterId > 0){
                      setState(() {
                        widget.game.insertWord(widget.game.letterId -1, Letter("", 0));
                        widget.game.letterId--;
                      });
                    }
                } else if  (e == "ENTRÉE"){
                  if(widget.game.letterId == 5){
                    String guess = widget.game.wordleBoard[widget.game.rowId].map((e) => e.letter).join();
                    if(widget.game.checkWordExist(guess)){
                      if(guess == WordleGame.game_guess){
                        setState(() {
                          WordleGame.msgGame = "GG !";
                          widget.game.wordleBoard[widget.game.rowId].forEach((element) {element.code = 1;});
                        });
                      } else {
                        int listLength = guess.length;
                        for (int i = 0; i < listLength; i++){
                          String char = guess[i];
                          if(WordleGame.game_guess.contains(char)){
                            if(WordleGame.game_guess[i] == char){
                              setState(() {
                                widget.game.wordleBoard[widget.game.rowId][i].code = 1;
                              });
                            } else {
                              setState(() {
                                widget.game.wordleBoard[widget.game.rowId][i].code = 2;
                                log("widget = 2");
                              });
                            }
                          }
                        }
                        widget.game.rowId++;
                        widget.game.letterId = 0;
                      }
                    }
                  } else {
                    WordleGame.msgGame = "Ce mot n'existe pas, réassayer";
                  }
                } else{
                  if(widget.game.letterId < 5){
                  setState(() {
                    widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                    widget.game.letterId++;
                  });
                }
                }
              },
              child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Text("${e}"),
            ));
          }).toList(),
        ),
      ],
    );
  }
}