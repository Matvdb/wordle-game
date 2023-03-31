import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Inscription extends StatefulWidget {
  const Inscription({super.key, required this.title});

  final String title;

  @override
  InscriptionState createState() => InscriptionState();
}

class InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  String _login = "";
  String _nom = "";
  String _prenom = "";
  String _password1 = "";
  String _password2 = "";
  String _email = "";


  Future<http.Response> createAccount(
      String login, String mdp, String nom, String prenom) {
    return http.post(
      Uri.parse(
          'https://s3-4427.nuage-peda.fr/wordle/public/api/users'),
      //'https://tanguy.ozano.ovh/Inno-v-Anglais/public/api/authentication_token'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(<String, dynamic>{
        "username": login,
        "roles": ["ROlE_USER"],
        "password": mdp,
        "nom": nom,
        "prenom": prenom,
      }),
    );
  }

  void checkAccount() async {
    var connexion = await createAccount(_login, _password1, _nom, _prenom);
    log(connexion.statusCode.toString());
    if (connexion.statusCode == 201) {
      Navigator.pushReplacementNamed(context, '/connexion');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Compte crée'),
      ));
    } else if (connexion.statusCode == 422) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login déjà utilisé'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Connexion au serveur impossible'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/connexion');
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
                      _password1 = valeur.toString();
                    }
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Confirmation du mot de passe"),
                  validator: (valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    } else if (valeur != _password1) {
                      return 'Mots de passe différents';
                    } else {
                      _password2 = valeur.toString();
                    }
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Prénom"),
                  validator: (valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return 'Veuillez entrer votre prénom';
                    } else {
                      _prenom = valeur.toString();
                    }
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Nom"),
                  validator: (valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return 'Veuillez entrer votre nom';
                    } else {
                      _nom = valeur.toString();
                    }
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return 'Veuillez entrer votre email';
                    } else {
                      _email = valeur.toString();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      checkAccount();
                    }
                  },
                  child: const Text("S'inscrire"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}