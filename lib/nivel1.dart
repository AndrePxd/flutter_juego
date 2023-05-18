import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_juego/widgets/wheel_animated.dart';

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
  flex: 3,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // Espacio para el libro y el autor
      Column(
        children: [
          Text(
            'Título del libro',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            'Autor del libro',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      // Espacio para el texto
      Container(
        color: Color.fromARGB(90, 114, 95, 10),
        child: Center(
          child: Text(
            'HOLA MUNDO PROBANDO',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  ),
),

          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (level >= 1) {
                            setState(() {
                              wheel1SelectedIndex =
                                  _getRandomIndex(wheel1SelectedIndex, wheel1Options.length);
                            });
                          }
                        },
                        child: Container(
                          height: 80, // Ajusta la altura según tus necesidades
                          width: double.infinity, // Ocupa todo el ancho disponible
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: level >= 1 ? Colors.white : Colors.grey,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              wheel1Options[wheel1SelectedIndex],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (level >= 2) {
                            setState(() {
                              wheel2SelectedIndex =
                                  _getRandomIndex(wheel2SelectedIndex, wheel2Options.length);
                            });
                          }
                        },
                        child: Container(
                          height: 80, // Ajusta la altura según tus necesidades
                          width: double.infinity, // Ocupa todo el ancho disponible
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: level >= 2 ? Colors.white : Colors.grey,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              wheel2Options[wheel2SelectedIndex],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (level >= 3) {
                            setState(() {
                              wheel3SelectedIndex =
                                  _getRandomIndex(wheel3SelectedIndex, wheel3Options.length);
                            });
                          }
                        },
                        child: Container(
                          height: 80, // Ajusta la altura según tus necesidades
                          width: double.infinity, // Ocupa todo el ancho disponible
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: level >= 3 ? Colors.white : Colors.grey,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              wheel3Options[wheel3SelectedIndex],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (level >= 1) {
                              setState(() {
                                wheel1SelectedIndex =
                                    _getRandomIndex(wheel1SelectedIndex, wheel1Options.length);
                              });
                            }
                          },
                          child: Container(
                            color: Colors.grey[500],
                            child: AnimatedNumberWheel(
                              number: wheel1SelectedIndex + 1,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (level >= 2) {
                              setState(() {
                                wheel2SelectedIndex =
                                    _getRandomIndex(wheel2SelectedIndex, wheel2Options.length);
                              });
                            }
                          },
                          child: Container(
                            color: Colors.grey[500],
                            child: AnimatedNumberWheel(
                              number: wheel2SelectedIndex + 1,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (level >= 3) {
                              setState(() {
                                wheel3SelectedIndex =
                                    _getRandomIndex(wheel3SelectedIndex, wheel3Options.length);
                              });
                            }
                          },
                          child: Container(
                            color: Colors.grey[500],
                            child: AnimatedNumberWheel(
                              number: wheel3SelectedIndex + 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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

  int _getRandomIndex(int currentIndex, int length) {
    final random = Random();
    int index = random.nextInt(length);
    while (index == currentIndex) {
      index = random.nextInt(length);
    }
    return index;
  }
}
