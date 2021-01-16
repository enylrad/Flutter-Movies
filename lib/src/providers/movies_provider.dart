import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_flutter/keys/api_the_movies.dart';
import 'package:movies_flutter/src/models/movies_model.dart';

class MoviesProvider {
  String _apiKey = apiKeyTheMoviesDb;
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> getMoviesCinema() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    Movies movies = await _processResponse(url);

    return movies.items;
  }

  Future<List<Movie>> getMoviesPopular() async {
    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
    });

    Movies movies = await _processResponse(url);

    return movies.items;
  }

  Future<Movies> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = Movies.fromJsonList(decodedData['results']);
    return movies;
  }

}
