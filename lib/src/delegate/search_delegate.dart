import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_flutter/src/models/movies_model.dart';
import 'package:movies_flutter/src/pages/movie_detail.dart';
import 'package:movies_flutter/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  String selection = '';
  final moviesProvider = MoviesProvider();

  final movies = [
    'test1',
    'test2',
    'test3',
    'test4',
    'test5',
    'test6',
  ];

  final moviesRecent = ['test1', 'test2'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones del App Bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono de la izquierda del App Bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultado que se van a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: moviesProvider.searchMovies(query),
        builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data;

            return ListView(
              children: movies.map((movie) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(movie.getPosterImage()),
                    placeholder: AssetImage('assets/image/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.originalTitle),
                  onTap: () {
                    close(context, null);
                    movie.uuid = '${movie.id}-search';
                    Navigator.pushNamed(
                      context,
                      MovieDetail.route,
                      arguments: movie,
                    );
                  },
                );
              }).toList(),
            );
          } else {
            return Center(
                child: Lottie.asset(
              'assets/lottie/loading-movie.json',
              height: 100.0,
              width: 100.0,
            ));
          }
        });
  }
}
