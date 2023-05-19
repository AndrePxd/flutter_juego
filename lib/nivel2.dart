import 'package:flutter/material.dart';
import 'package:flutter_juego/score.dart';

class WordItem {
  String word;
  bool isDragged;
  WordItem(this.word, {this.isDragged = false});
}

class DragAndDropScreen extends StatefulWidget {
  @override
  _DragAndDropScreenState createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  List<WordItem> words = [
    WordItem('Elemento 1'),
    WordItem('Elemento 2'),
    WordItem('Elemento 3'),
    WordItem('Elemento 4'),
    WordItem('Elemento 5'),
    WordItem('Elemento 6'),
    WordItem('Elemento 7'),
    WordItem('Elemento 8'),
    WordItem('Elemento 9'),
    WordItem('Elemento 10'),
  ];

  List<WordItem> droppedWords = [];
  List<String> correctStrings = [
    'Elemento 1 Elemento 3',
    'Elemento 4, Elemento 5'
  ];

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
            'assets/images/niv2.PNG',
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
                  return Draggable<WordItem>(
                    data: words[index],
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: words[index].isDragged
                            ? Colors.blue.shade800
                            : Colors.green.shade800,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        words[index].word,
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
                        words[index].word,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    childWhenDragging: Container(),
                    maxSimultaneousDrags: words[index].isDragged ? 0 : 1,
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: DragTarget<WordItem>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: droppedWords.map((wordItem) {
                      return Draggable<WordItem>(
                        data: wordItem,
                        child: Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            wordItem.word,
                            style: TextStyle(fontSize: 16, color: Colors.black),
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
                            wordItem.word,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        childWhenDragging: Container(),
                        onDragEnd: (details) {
                          if (!details.wasAccepted) {
                            setState(() {
                              wordItem.isDragged = false;
                              droppedWords.remove(wordItem);
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                );
              },
              onAccept: (wordItem) {
                setState(() {
                  wordItem.isDragged = true;
                  droppedWords.add(wordItem);
                });
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  int score = 0;
                  for (WordItem wordItem in droppedWords) {
                    for (String correctString in correctStrings) {
                      if (correctString.contains(wordItem.word)) {
                        score++;
                        break;
                      }
                    }
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScoreScreen(
                          score: score,
                          coins: 10,
                          stars: 5,
                          maxScore: correctStrings.length + 1),
                    ),
                  );
                },
                child: Text('Terminar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
