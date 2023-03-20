import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordle/outils/game_keyboard.dart';
import 'package:wordle/outils/wordle.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final WordleGame _game = WordleGame();

  @override
  void initState(){
    super.initState();
    WordleGame.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade700,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GameKeyboard(_game),
          ],
        ),
      ),
    );
  }
}