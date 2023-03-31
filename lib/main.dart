import 'package:flutter/material.dart';
import 'package:wordle/ecrans/connexion.dart';
import 'package:wordle/ecrans/game.dart';
import 'package:wordle/ecrans/inscription.dart';
import 'package:wordle/ecrans/myhomepage.dart';
import 'package:wordle/ecrans/profil.dart';
import 'package:wordle/splash/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/wordle': (BuildContext context) => const GameScreen(),
        '/inscription': (BuildContext context) => const Inscription(title: "Inscritpion"),
        '/connexion': (BuildContext context) => const Connexion(),
        '/home': (BuildContext context) => const MyHomePage(title: "Wordle",),
        '/profil': (BuildContext context) => const Profil(title: "Profil",),
      }
    );
  }
}


