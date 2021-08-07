import 'dart:convert';

//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/bloc/login/login_state.dart';
import 'package:login_app/model/card_model.dart';

class UserRepository {
  static Uri url = Uri(
    scheme: 'https',
    host: 'trello.backend.tests.nekidaem.ru',
    path: '/api/v1/users/login/',
  );

  //final FlutterSecureStorage storage = FlutterSecureStorage();

  // Future<bool> hasToken() async {
  //   var value = await storage.read(key: 'token');
  //   if (value != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // Future<void> persistToken(String token) async {
  //   await storage.write(key: 'token', value: token);
  // }
  //
  // Future<void> deleteToken() async {
  //   storage.delete(key: 'token');
  //   storage.deleteAll();
  // }

  // Future<bool> login(String username, String password) async {
  //   http.Response response = await http
  //       .post(url, body: {'username': 'armada', 'password': 'FSH6zBZ0p9yH'});
  //   //Map<String, dynamic> decodedJsonMap;
  //   bool isAcceptedLogin = false;
  //   if (response.statusCode == 201) {
  //     //decodedJsonMap = jsonDecode(response.body);
  //     debugPrint(response.statusCode.toString());
  //     isAcceptedLogin = true;
  //   } else {
  //     throw Exception('Failed to log in');
  //   }
  //
  //   return isAcceptedLogin;
  // }

  Future<bool> login(String username, String password, LoginState state) async {
    bool loginIsAccepted = false;
    if (state.isValidPassword && state.isValidUsername) {
      final response = await http
          .post(url, body: {'username': username, 'password': password});
      print(response.statusCode);

      Map<String, dynamic> decodedJsonMap = jsonDecode(response.body);
      String token = decodedJsonMap['token'];

      if (token != null) {
        loginIsAccepted = true;
      }
    }

    return loginIsAccepted;
  }

  Future<String> fetchCards(String username, String password) async {
    Uri urlData = Uri(
      scheme: 'https',
      userInfo: '$username:$password',
      host: 'trello.backend.tests.nekidaem.ru',
      path: '/api/v1/cards/',
    );
    final response = await http.get(urlData);
    var jsonStr = response.body;

    return jsonStr;
  }

  Future<List<Cards>> getCards(String username, String password) async {
    String jsonStr = await fetchCards(username, password);
    return cardFromJson(jsonStr);
  }
}
