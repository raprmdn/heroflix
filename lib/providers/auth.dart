import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {

  final String _urlMaster = "http://10.0.2.2:8000/api";

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
      if (responseData['error'] != null) {
        throw responseData['error'];
      }

      return responseData;

    } catch (e) {
      throw(e);
    }

  }

}