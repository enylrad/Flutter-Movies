import 'package:flutter/material.dart';
import 'package:movies_flutter/src/models/movies_model.dart';
import 'package:movies_flutter/src/pages/movie_detail.dart';

class MoviesHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  MoviesHorizontal({@required this.movies, @required this.nextPage});

  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      var currentPixelPosition = _pageController.position.pixels;
      var pixelEndCondition = _pageController.position.maxScrollExtent - 200;

      if (currentPixelPosition >= pixelEndCondition) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.22,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, index) => _card(context, movies[index]),
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {

    movie.uuid = '${movie.id}-poster';

    final card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: movie.uuid,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/images/no-image.jpg'),
                image: NetworkImage(movie.getPosterImage()),
                fit: BoxFit.cover,
                height: 150.0,
                width: 110.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, MovieDetail.route, arguments: movie);
      },
    );
  }
}
