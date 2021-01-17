import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_flutter/src/models/movies_model.dart';
import 'package:movies_flutter/src/pages/movie_detail.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.45,
        itemBuilder: (BuildContext context, int index) {
          movies[index].uuid = '${movies[index].id}-card';

          return Hero(
            tag: movies[index].uuid,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/no-image.jpg'),
                  image: NetworkImage(movies[index].getPosterImage()),
                  fit: BoxFit.cover,
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  MovieDetail.route,
                  arguments: movies[index],
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
