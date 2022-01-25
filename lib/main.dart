

import 'package:flutter/material.dart';
import 'package:i_matches/Route/routes.dart' as route;
import 'package:i_matches/Screens/Login/login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.lightBlue
              ),
            debugShowCheckedModeBanner: false,
            home: LoginPage(), 
            onGenerateRoute: route.controller,
            initialRoute: route.login,
          );
  }
}