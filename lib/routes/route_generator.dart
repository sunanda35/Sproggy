import 'package:flutter/material.dart';
import 'package:sproggy/error/error_page.dart';
import 'package:sproggy/pages/second_page.dart';

import '../pages/home_page.dart';

class RouteGenerator {


  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/login':
        if (args is String) {
        return MaterialPageRoute(builder: (_) => Second(data: args));
        } else {
          return MaterialPageRoute(builder: (_) => ErrorPage());
        }
      default:
          return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }
}
