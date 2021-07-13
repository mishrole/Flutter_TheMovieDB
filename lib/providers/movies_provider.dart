import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculasapp/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MoviesProvider extends ChangeNotifier {

  String _baseUrl = 'api.themoviedb.org';
  Map<String, dynamic> _query = {
    'api_key': dotenv.env['THEMOVIEDB_APIKEY'], 
    'language': 'es-ES', 
    'page': '1'
  };

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider init');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1] ) async {
    var url = Uri.https( _baseUrl, endpoint, {
      'api_key': dotenv.env['THEMOVIEDB_APIKEY'], 
      'language': 'es-ES', 
      'page': '$page'
    });

    // Await the http get response, then decode the json-formatted response
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {

    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {

    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
  
    popularMovies = [...popularMovies, ...popularResponse.results];

    notifyListeners();
  }
}