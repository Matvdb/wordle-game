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
  int point = 0;

  void score(){ // Fonction ajoutant 1 de score à chaque fois que le Joueur gagne la partie
    if(widget.game.letterId == 5){
      String guess = widget.game.wordleBoard[widget.game.rowId].map((e) => e.letter).join();
      if(widget.game.checkWordExist(guess)){
        if(guess == WordleGame.gameguess){
          point++;
        }
      }
    }
  }

  Future<void> _restartGame(){
    return showDialog(
      context: context, 
      builder: (BuildContext context){
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
    );
  }


  Future<void> _win() async { // Widget affichant un pop-up lorsque le Joueur a gagné
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Félicitations 🎉', style: TextStyle(fontSize: 30.0),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Gagnée 🎊',style: TextStyle(fontSize: 25.0),),
                Text('Vous venez de trouvez le mot !'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continuer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  Future<void> _loose() async { // Widget affichant un pop-up lorsque le Joueur a perdu
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dommage... 😫', style: TextStyle(fontSize: 28.0),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Défaite 🥴',style: TextStyle(fontSize: 25.0),),
                Text("Vous n'avez pas réussi à trouver le mot, réessayer !"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continuer'),
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame();
              },
            ),
          ],
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$point", 
          style: const TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold, 
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        GameBoard(widget.game),
        const SizedBox(
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
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Text("${e}"),
              ),
            );
          }).toList(),
        ),
        const SizedBox(
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
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Text("${e}"),
            ));
          }).toList(),
        ),
        const SizedBox(
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
                      if(guess == WordleGame.gameguess){
                        setState(() {
                          score();
                          _win();
                          widget.game.wordleBoard[widget.game.rowId].forEach((element) {element.code = 1;});
                        });
                      } else {
                        int listLength = guess.length;
                        for (int i = 0; i < listLength; i++){
                          String char = guess[i];
                          if(WordleGame.gameguess.contains(char)){
                            if(WordleGame.gameguess[i] == char){
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
                    setState(() {
                      _loose();
                    });
                    WordleGame.msgGame = "Ce mot n'existe pas, réessayer";
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