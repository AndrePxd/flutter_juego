import 'package:flutter/material.dart';

import 'menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Quijote de la Mancha',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MenuScreen(),
    );
  }
}
