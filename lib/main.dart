import 'package:flutter/material.dart';

import 'Nivel1.dart';
import 'login.dart';
import 'map.dart';
import 'menu.dart';

void main() {
  runApp(MyApp());
}

final ThemeData temaDonQuijote = ThemeData(
  primarySwatch: Colors.brown,
  fontFamily: 'Alegreya',
  textTheme: TextTheme(
    headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Quijote de la Mancha',
      theme: temaDonQuijote,
      home: LoginScreen(),
    );
  }
}
