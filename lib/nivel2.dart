import 'package:flutter/material.dart';

class DragAndDropScreen extends StatefulWidget {
  @override
  _DragAndDropScreenState createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  List<String> words = [
    'Hola 1',
    'Hola 2',
    'Hola 3',
    'Hola 4',
    'Hola 5',
    'Hola 6',
    'Hola 7',
    'Hola 8',
    'Hola 9',
    'Hola 10',
  ];

  List<String> droppedWords = []; // Lista para almacenar las palabras soltadas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text('NIVEL 2 - EL QUIJOTE DE LA MANCHA'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/niv2.PNG', // Replace with your background image
            fit: BoxFit.fitHeight,
            width: 700,
            height: 700,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: words.length,
                itemBuilder: (context, index) {
                  return Draggable<String>(
                    data: words[index],
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade800,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        words[index],
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    feedback: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        words[index],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    childWhenDragging: Container(),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: DragTarget<String>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      droppedWords.join(' '), // Mostrar las palabras soltadas
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
              onAccept: (word) {
                setState(() {
                  droppedWords
                      .add(word); // Agregar la palabra soltada a la lista
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
