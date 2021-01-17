import 'package:flutter/material.dart';
import 'package:movies_flutter/src/models/actors_model.dart';

class ActorsHorizontal extends StatelessWidget {
  final List<Actor> actors;

  ActorsHorizontal({@required this.actors});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.22,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actors.length,
        itemBuilder: (context, index) => _card(context, actors[index]),
      ),
    );
  }

  Widget _card(BuildContext context, Actor actor) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage(actor.getPhotoImage()),
              fit: BoxFit.cover,
              height: 150.0,
              width: 110.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
