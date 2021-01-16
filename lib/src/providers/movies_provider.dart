import 'dart:convert';

import 'package:movies_flutter/keys/api_the_movies.dart';
import 'package:movies_flutter/src/models/movies_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = apiKeyTheMoviesDb;
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> getMoviesCinema() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }
}
