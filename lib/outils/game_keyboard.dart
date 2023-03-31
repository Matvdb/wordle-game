

import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordle/outils/game_board.dart';
import 'package:wordle/outils/wordle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
  bool _aGagner = false;
  bool _recupDataBool = false;
  int _status_code = -1;
  Map<String, dynamic> _mots = new Map();


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

  Future<String> recupMot() async { // Fonction qui récupère la liste de mots de l'API
    String url =
        "https://s3-4427.nuage-peda.fr/apiWordle/public/api/mots";
    var reponse = await http.get(Uri.parse(url));
    String result = 'pas de result';
    _status_code = reponse.statusCode;
    if (reponse.statusCode == 200) {
      _mots = convert.jsonDecode(reponse.body);
      _recupDataBool = true;
      result = 'result';
    }
    await Future.delayed(const Duration(seconds: 1));
    return result;
  }


  Future<void> _win() async { // Widget affichant un pop-up lorsque le Joueur a gagné
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Félicitations 🎉', style: TextStyle(fontSize: 28.0),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Gagnée !',style: TextStyle(fontSize: 25.0), textAlign: TextAlign.center,),
                Text('Vous venez de trouvez le mot !'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Quitter'),
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
            ),
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
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: (){
            WordleGame.initGame();
          }, 
          child: const Text("Recommencer"),
        ),
        const SizedBox(
          height: 10.0,
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
                // logique
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
                          _aGagner = true;
                          WordleGame.msgGame == "GG";
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
                      _aGagner = false;
                      _loose();
                    });
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