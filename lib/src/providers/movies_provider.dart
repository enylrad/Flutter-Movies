import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_flutter/keys/api_the_movies.dart';
import 'package:movies_flutter/src/models/actors_model.dart';
import 'package:movies_flutter/src/models/movies_model.dart';

class MoviesProvider {
  String _apiKey = apiKeyTheMoviesDb;
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _pageMoviesPopulars = 0;
  bool _loading = false;

  List<Movie> _moviesPopulars = List();

  final _moviesPopularsStreamController =
      StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get moviesPopularsSink =>
      _moviesPopularsStreamController.sink.add;

  Stream<List<Movie>> get moviesPopularsStream =>
      _moviesPopularsStreamController.stream;

  void disposeStream() {
    _moviesPopularsStreamController?.close();
  }

  Future<List<Movie>> getMoviesCinema() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    List<Movie> movies = await _processResponse(url);

    return movies;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_url, '/3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    List<Movie> movies = await _processResponse(url);

    return movies;
  }

  Future<List<Movie>> getMoviesPopulars() async {
    if (_loading) return [];
    _loading = true;

    _pageMoviesPopulars++;

    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _pageMoviesPopulars.toString()
    });

    final response = await _processResponse(url);

    _moviesPopulars.addAll(response);
    moviesPopularsSink(_moviesPopulars);

    _loading = false;
    return response;
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '/3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final cast = Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }
}
