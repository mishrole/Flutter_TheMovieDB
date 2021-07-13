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

  MoviesProvider() {
    print('MoviesProvider init');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(
      _baseUrl, 
      '3/movie/now_playing', 
      _query
    );

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    
    onDisplayMovies = nowPlayingResponse.results;

    // Redibujar al hacer un cambio
    notifyListeners();
    // print(nowPlayingResponse.results[0].title);
  }

  getPopularMovies() async {
    var url = Uri.https(
      _baseUrl, 
      '3/movie/popular', 
      _query
    );

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    
    popularMovies = [...popularMovies, ...popularResponse.results];

    // Redibujar al hacer un cambio
    notifyListeners();
  }
}