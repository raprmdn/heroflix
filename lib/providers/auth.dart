import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {

  final String _urlMaster = "http://10.0.2.2:8000/api";
  var token;

  _getToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  signUp(String name, String email, String password, String passwordConfirmation) async {
    String endpoint = "/register";
    Uri url = Uri.parse(_urlMaster + endpoint);

    try {
      var response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password,
            'password_confirmation': passwordConfirmation,
          })
      );
      var responseData = jsonDecode(response.body);
      print(responseData);

      if (responseData['errors'] != null) {
        throw responseData['errors'];
      }

      return responseData;
    } catch (e) {
      throw(e);
    }
  }

  signIn(String email, String password) async {
    String endpoint = '/login';
    Uri url = Uri.parse(_urlMaster + endpoint);

    try {
      var response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'email': email,
            'password': password,
            'device_name': 'mobile',
          })
      );
      var responseData = jsonDecode(response.body);
      print(responseData);

      if (responseData['errors'] != null) {
        throw responseData['errors'];
      }

      if (responseData['status']) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', json.encode(responseData['token']));
        localStorage.setString('user', json.encode(responseData['user']));
      }

      return responseData;
    } catch (e) {
      throw(e);
    }
  }

  logout() async {
    String  endpoint = '/logout';
    Uri url = Uri.parse(_urlMaster + endpoint);

    try {
      await _getToken();
      var response = await http.post(
          url,
          headers: _setHeaders(),
      );
      var responseData = jsonDecode(response.body);
      print(responseData);

      if (responseData['status']) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.remove('user');
        localStorage.remove('token');
      }

      return responseData;
    } catch (e) {
      throw(e);
    }
  }

}