import 'package:flutter/material.dart';
import 'package:movies_flutter/src/pages/home_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    HomePage.route: (BuildContext context) => HomePage(),
  };
}

String getDefaultRoute() => HomePage.route;
