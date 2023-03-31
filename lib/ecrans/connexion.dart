import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:wordle/outils/api.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final _formKey = GlobalKey<FormState>();
  String _login = "";
  String _password = "";
  final bool _connexion = false;
  String localLogin = "";
  String localPassword = "";
  String localToken = "";

  static Future<http.Response> recupConnect(String email, String mdp) {
    return http.post(
      Uri.parse("https://s3-4427.nuage-peda.fr/wordle/public/api/" + 'authentication_token'),
      headers: <String, String>{
        'Accept': 'application/json; charset=UTF-8',
        'Content-Type': 'application/json',
      },
      body: convert
          .jsonEncode(<String, String>{'email': email, 'password': mdp}),
    );
  }

  void afficheToken() async {
    var connexion = await recupConnect(_login, _password);
    log(_login);
    log(_password);
    if (connexion.statusCode == 200) {
      localLogin = _login;
      localPassword = _password;
      var data = convert.jsonDecode(connexion.body);
      var token = data['token'].toString();
      localToken = token;
      log(token);
      Navigator.pushReplacementNamed(context, '/home');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bienvenue ", style: TextStyle(
              fontSize: 13.0,
            ),),
            Text("$_login", style: TextStyle(
              fontSize: 15.0,
              color: Colors.yellow.shade400,
            ),)
          ],
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Connexion impossible'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connexion"),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/inscription');
                },
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Login"),
                  validator: (valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return 'Veuillez entrer votre login';
                    } else {
                      _login = valeur.toString();
                    }
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Mot de passe"),
                  validator: (valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    } else {
                      _password = valeur.toString();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      afficheToken();
                    }
                  },
                  child: const Text("Se connecter"),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/home'), 
                child: Text("Continuer sans connexion"))
            ],
          ),
        ),
      ),
    );
  }
}