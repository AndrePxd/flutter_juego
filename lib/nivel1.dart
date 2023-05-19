import 'dart:async';
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

enum Difficulty {
  easy,
  medium,
  hard,
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

  Difficulty selectedDifficulty = Difficulty.easy; // Dificultad seleccionada

  late Timer _timer;
  int _secondsRemaining = 5;

  //Identificar que el temporizador se ha terminado
  bool get timerHasFinished => _secondsRemaining == 0;
  

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          // Aquí puedes agregar la lógica cuando el tiempo se agota
          if(timerHasFinished){
            print('El tiempo se ha terminado');
            level=0;

  }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juego de Ruedas'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'Tiempo: $_secondsRemaining',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                              wheel1SelectedIndex = _getRandomIndex(
                                  wheel1SelectedIndex, wheel1Options.length);
                                  startTimer();
                            });
                          }
                        },
                        child: Container(
                          height: 80,
                          width: double.infinity,
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
                              wheel2SelectedIndex = _getRandomIndex(
                                  wheel2SelectedIndex, wheel2Options.length);
                            });
                          }
                        },
                        child: Container(
                          height: 80,
                          width: double.infinity,
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
                              wheel3SelectedIndex = _getRandomIndex(
                                  wheel3SelectedIndex, wheel3Options.length);
                            });
                          }
                        },
                        child: Container(
                          height: 80,
                          width: double.infinity,
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
                                wheel1SelectedIndex = _getRandomIndex(
                                    wheel1SelectedIndex, wheel1Options.length);
                              });
                            }
                          },
                          child: Container(
                            color: Color.fromARGB(255, 253, 252, 252),
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
                                wheel2SelectedIndex = _getRandomIndex(
                                    wheel2SelectedIndex, wheel2Options.length);
                              });
                            }
                          },
                          child: Container(
                            color: Color.fromARGB(255, 250, 246, 246),
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
                                wheel3SelectedIndex = _getRandomIndex(
                                    wheel3SelectedIndex, wheel3Options.length);
                              });
                            }
                          },
                          child: Container(
                            color: Color.fromARGB(255, 247, 245, 245),
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
              color: Color.fromARGB(255, 252, 251, 251),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Progreso',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 15,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 238, 238),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.brown[600],
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [

              //ESTE BOTON ES DE PRUEBA PARA VERIFICAR QUE SI SE BLOQUEAN LOS BOTONES
              ElevatedButton(
                onPressed: () {
                  if (level < 3) {
                    setState(() {
                      level++;
                      selectedDifficulty = Difficulty.values[level - 1];
                    });
                  } else {
                    // Fin del juego, mostrar puntaje, reiniciar nivel, etc.
                  }
                },
                child: Text('Siguiente nivel'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    level = 1;
                    wheel1SelectedIndex = 0;
                    wheel2SelectedIndex = 0;
                    wheel3SelectedIndex = 0;
                    selectedDifficulty = Difficulty.easy;
                    _secondsRemaining = 5;
                  });
                },
                child: Text('Reiniciar'),
              ),
            ],
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
