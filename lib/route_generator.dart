import 'package:flutter/material.dart';
import 'package:kdresponse/src/pages/home_screen.dart';
import 'package:kdresponse/src/pages/setup_screen.dart';
import 'package:kdresponse/src/pages/splash_screen.dart';

import 'src/models/route_argument.dart';




class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch (settings.name){
      case '/Splash':
        return MaterialPageRoute(builder: (_)=>SplashScreen());
      case '/Setup':
        return MaterialPageRoute(builder: (_)=>SetupScreen(routeArgument: args as RouteArgument));
      case '/Home':
        return MaterialPageRoute(builder: (_)=>HomeScreen(routeArgument: args as RouteArgument));
    }
  }
}


