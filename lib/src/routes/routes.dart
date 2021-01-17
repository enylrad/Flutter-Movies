import 'package:flutter/material.dart';
import 'package:movies_flutter/src/pages/home_page.dart';
import 'package:movies_flutter/src/pages/movie_detail.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    HomePage.route: (BuildContext context) => HomePage(),
    MovieDetail.route: (BuildContext context) => MovieDetail(),
  };
}

String getDefaultRoute() => HomePage.route;
