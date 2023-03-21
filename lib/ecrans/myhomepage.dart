import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordle/ecrans/game.dart';
import 'package:wordle/outils/strings.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool estClique = false;

  Future<void> _popUpConnexion() async { // Widget affichant un pop-up de connexion
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Vérification rapide', style: TextStyle(fontSize: 20.0),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Avez-vous un compte ?',style: TextStyle(fontSize: 15.0),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Non'),
              onPressed: () {
                Navigator.pushNamed(context, "/inscription");
              },
            ),
            TextButton(
              child: const Text('Oui'),
              onPressed: () {
                Navigator.pushNamed(context, "/connexion");
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const Image(image: AssetImage("assets/wordle.png")),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const Text("Bienvenue sur le jeu du", 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: (){
                setState(() {
                  estClique = true;
                });
              }, 
              child: Text("Wordle", 
                style: TextStyle(
                  fontSize: 35.00,
                  fontWeight: FontWeight.bold,
                  color: estClique == false 
                  ? Colors.white
                  : estClique == true
                    ?Colors.red:Colors.green,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(8)),
            IconButton(
              onPressed: () {
                setState(() {
                  _popUpConnexion();
                });
              }, 
              icon: Icon(Icons.person_rounded),
              color: Colors.white,
              tooltip: "Inscription",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white38,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(padding: EdgeInsets.all(10)),
                  Text("À lire avant de jouer",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(Strings.titreHPRegle, 
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  Text(Strings.regleGame,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Align(
                    alignment: Alignment.center,
                    child: Text(Strings.provoc,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(40)),
                  Text(Strings.titreHPWordle, 
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  Text(Strings.wordleDesc,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameScreen(),
            ));
        },
        label: const Text("Lancez votre première partie"),
        icon: const Icon(Icons.play_arrow),
        hoverColor: Colors.orange,
        splashColor: Colors.white,
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}