import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wordle/ecrans/game.dart';
import 'package:wordle/outils/api.dart';
import 'package:wordle/outils/strings.dart';

class Profil extends StatefulWidget {
  const Profil({super.key, required this.title});

  final String title;

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String _nom = '';
  String _prenom = '';
  String _login = '';
  String _email = "";
  String _role = "";
  String _err = '';
  Api api = Api();
  var user;
  bool recupDataBool = false;
  bool estClique = false;

  void recupProfil() async {
    user = await api.getUser();
    if (user != null || !user.isEmpty) {
      setState(() {
        _nom = user['nom'].toString();
        _prenom = user['prenom'].toString();
        _login = user['username'].toString();

        recupDataBool = true;
        _err = '';
      });
    } else {
      _err = 'Erreur lors de la récupération des données';
    }
  }

  @override
  Widget build(BuildContext context) {
    /* if (!recupDataBool) {
      recupProfil();
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SpinKitCubeGrid(
                        color: Colors.orange,
                        size: 100,
                      )
                    ])
              ]));
    } */
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        centerTitle: true,
      ),
      backgroundColor: Colors.green.shade900,
      body: Center(
        child: Column(
          children: [
            Text("$_nom"),
          ],
        ),
      ),
    );
  }
}