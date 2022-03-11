import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';

import '../screens/more/more_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This is route: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case DermaScreen.routeName:
        return DermaScreen.route();
      case ProgramScreen.routeName:
        return ProgramScreen.route();
      case TanyaScreen.routeName:
        return TanyaScreen.route();
       case MoreScreen.routeName:
         return MoreScreen.route();
      case TanyaImamScreen.routeName:
        return TanyaImamScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
          appBar: AppBar(
        title: Text('Error'),
      )),
    );
  }
}
