import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:wordle/outils/local.dart';

class Api {
  String _login = localLogin;
  String _password = localPassword;
  String _token = localToken;

  Api();

  static Future<http.Response> recupConnect(String login, String mdp) {
    return http.post(
      Uri.parse(localUrl + 'authentication_token'),
      //'https://tanguy.ozano.ovh/Inno-v-Anglais/public/api/authentication_token'),
      headers: <String, String>{
        'Accept': 'application/json; charset=UTF-8',
        'Content-Type': 'application/json',
      },
      body: convert
          .jsonEncode(<String, String>{'username': login, 'password': mdp}),
    );
  }

  Future<void> UpdateToken() async {
    var connexion = await Api.recupConnect(_login, _password);
    if (connexion.statusCode == 200) {
      var data = convert.jsonDecode(connexion.body);
      localToken = data['token'].toString();
    }
  }

  Future<http.Response> getUsers() async {
    await UpdateToken();
    return http.get(
      Uri.parse(localUrl + 'users'),
      headers: <String, String>{
        //'Accept': 'application/json',
        'Authorization': "Bearer $localToken",
      },
    );
  }

  Future<dynamic> getUser() async {
    var data = convert.jsonDecode((await getUsers()).body);
    var user;
    log(data.toString());
    for (var elt in data['hydra:member']) {
      if (elt['username'] == localLogin) {
        user = elt;
      }
    }
    return user;
  }
}