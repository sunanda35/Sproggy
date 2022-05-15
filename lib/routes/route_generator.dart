import 'package:flutter/material.dart';
import '../Error/error_page.dart';
import '../Pages/second_page.dart';
import '../Pages/home_page.dart';

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
