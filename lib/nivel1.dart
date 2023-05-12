import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego de Ruedas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int level = 1;
  List<String> wheel1Options = ['Cita corta', 'Cita larga', 'Paráfrasis'];
  List<String> wheel2Options = ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4'];
  List<String> wheel3Options = [
    'Respuesta 1',
    'Respuesta 2',
    'Respuesta 3',
    'Respuesta 4'
  ];

  int wheel1SelectedIndex = 0;
  int wheel2SelectedIndex = 0;
  int wheel3SelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juego de Ruedas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildWheel(wheel1Options, wheel1SelectedIndex, level >= 1,
                    (index) {
                  setState(() {
                    wheel1SelectedIndex = index;
                  });
                }),
                buildWheel(wheel2Options, wheel2SelectedIndex, level >= 2,
                    (index) {
                  setState(() {
                    wheel2SelectedIndex = index;
                  });
                }),
                buildWheel(wheel3Options, wheel3SelectedIndex, level >= 3,
                    (index) {
                  setState(() {
                    wheel3SelectedIndex = index;
                  });
                }),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[500],
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (level < 3) {
                setState(() {
                  level++;
                });
              } else {
                // Fin del juego, mostrar puntaje, reiniciar nivel, etc.
              }
            },
            child: Text('Siguiente nivel'),
          ),
        ],
      ),
    );
  }

  Widget buildWheel(List<String> options, int selectedIndex, bool isEnabled,
      ValueChanged<int> onSelectionChanged) {
    return GestureDetector(
      onTap: () {
        if (!isEnabled) return;
        final random = Random();
        int index = random.nextInt(options.length);
        while (index == selectedIndex) {
          index = random.nextInt(options.length);
        }
        onSelectionChanged(index);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.white : Colors.grey,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          options[selectedIndex],
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
