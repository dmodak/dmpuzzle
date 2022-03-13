import 'package:dmpuzzle/ui/page/dm_game/dm_game_page.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String HomeViewRoute = '/';
  static const String DmGameRoute = '/DmGame';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.DmGameRoute:
        return MaterialPageRoute(builder: (context) => DmGameGridPage());
      default:
        return MaterialPageRoute(builder: (context) => DmGameGridPage());
    }
  }
}
