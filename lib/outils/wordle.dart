import 'dart:math';

class WordleGame{
  // Intelligence du jeu

  int rowId = 0;
  int letterId = 0;

  static String msgGame = "";
  static String gameguess = "";
  static List<String> listmot = [
    "TESTE",
    "AIMER",
    "FEURE",
    "MANGE",
    "ZEUBI",
    "IDEES",
  ];

  static bool gameOver = false;

  static List<Letter> wordleRow = List.generate(5, (index) => Letter("", 0));

  List<List<Letter>> wordleBoard = List.generate(5, (index) => List.generate(5, ((index) => Letter("", 0))));

  static void initGame(){
    final random = new Random();
    int index = random.nextInt(listmot.length);
    gameguess = listmot[index];
  }

  void insertWord(index, word){
    wordleBoard[rowId][index] = word;
  }

  bool checkWordExist(String word){
    return listmot.contains(word);
  }
}

class Letter{
  String? letter;
  int code = 0;
  Letter(this.letter, this.code);

}