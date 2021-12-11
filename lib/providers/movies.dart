import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Movies with ChangeNotifier{

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

  listMovies() async {
    String endpoint = '/movies';
    Uri url = Uri.parse(_urlMaster + endpoint);

    try {
      await _getToken();
      var response = await http.get(
        url,
        headers: _setHeaders(),
      );
      var responseData = jsonDecode(response.body);
      print(responseData);

      return responseData;

    } catch (e) {
      print(e);
      throw(e);
    }
  }

}