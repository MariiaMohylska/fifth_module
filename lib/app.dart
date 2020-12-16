import 'package:flutter/material.dart';

import 'app_route.dart';
import 'screens.dart';
//
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MaterialApp(
        color: Colors.purple,
        onUnknownRoute: (settings) => MaterialPageRoute(
            settings: RouteSettings(name: '/error'),
            builder: (context)=>NavigationErrorScreen(
              routeSettings: settings,
            )),
        routes: {
          AppRoute.first: (context) => FirstScreen(),
          AppRoute.second: (context) => SecondScreen(),
        },
      ),
    );
  }
}

