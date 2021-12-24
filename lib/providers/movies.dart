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
      throw(e);
    }
  }

  showMovies(int trackId) async {
    String endpoint = '/movies/track/$trackId';
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
      throw(e);
    }
  }

  saveMovies(String title, String description, String ageRestricted,
      int releaseYear, String season, String genre, String thumbnail, String actor, String director) async {
    String endpoint = '/movies/create';
    Uri url = Uri.parse(_urlMaster + endpoint);

    try {
      await _getToken();
      var response = await http.post(
        url,
        headers: _setHeaders(),
        body: jsonEncode({
          'title': title,
          'description': description,
          'age_restricted': ageRestricted,
          'release_year': releaseYear,
          'season': season,
          'genre': genre,
          'thumbnail': thumbnail,
          'starring': actor,
          'director': director,
        })
      );
      var responseData = jsonDecode(response.body);
      print(responseData);

      return responseData;
    } catch (e) {
      throw(e);
    }
  }

  updateMovies(String title, String description, String ageRestricted,
      int releaseYear, String season, String genre, String thumbnail, String actor, String director, int trackId) async {
    String endpoint = '/movies/$trackId';
    Uri url = Uri.parse(_urlMaster + endpoint);

    try {
      await _getToken();
      var response = await http.put(
          url,
          headers: _setHeaders(),
          body: jsonEncode({
            'title': title,
            'description': description,
            'age_restricted': ageRestricted,
            'release_year': releaseYear,
            'season': season,
            'genre': genre,
            'thumbnail': thumbnail,
            'starring': actor,
            'director': director,
          })
      );
      var responseData = jsonDecode(response.body);
      print(responseData);

      return responseData;
    } catch (e) {
      throw(e);
    }
  }

  deleteMovies(int trackId) async {
    String endpoint = '/movies/$trackId';
    Uri url = Uri.parse(_urlMaster + endpoint);

    try {
      await _getToken();
      var response = await http.delete(
        url,
        headers: _setHeaders(),
      );
      var responseData = jsonDecode(response.body);
      print(responseData);

      return responseData;
    } catch (e) {
      throw(e);
    }
  }
}