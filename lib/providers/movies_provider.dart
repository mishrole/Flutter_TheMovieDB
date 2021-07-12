import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculasapp/models/now_playing_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MoviesProvider extends ChangeNotifier {

  String _baseUrl = 'api.themoviedb.org';
  String _lang = 'es-ES';

  MoviesProvider() {
    print('MoviesProvider init');

    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(
      _baseUrl, 
      '3/movie/now_playing', 
      {
        'api_key': dotenv.env['THEMOVIEDB_APIKEY'], 
        'language': _lang, 
        'page': '1'
      }
    );

    final response = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    // final Map<String, dynamic> decodedData = json.decode(response.body);

    print(nowPlayingResponse.results[0].title);
  }
}