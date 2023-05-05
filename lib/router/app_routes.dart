import 'package:flutter/material.dart';
import 'package:flutter_juego/login.dart';
import 'package:flutter_juego/menu.dart';

import '../alert.dart';
import '../models/menu_option.dart';

class AppRoutes {
  static const intialRoute = '/';
  static final routes = <MenuOption>[
    MenuOption(
      route: '/levels_screen',
      screen: MenuScreen(),
    ),
  ];

  //mapa de rutas
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'/': (BuildContext context) => LoginScreen()});
    // appRoutes.addAll({'/': (BuildContext context) => LoginScreen()});

    for (final option in routes) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  //ruta por defecto
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const AlertScreen());
  }
}
