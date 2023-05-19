import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  final int coins;
  final int stars;
  final int maxScore;

  ScoreScreen(
      {required this.score,
      required this.coins,
      required this.stars,
      required this.maxScore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade400,
      appBar: AppBar(
        title: Text('Puntuación'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/pergamino.png', // Asegúrate de reemplazar 'assets/images/background.png' con la ruta de tu imagen de fondo
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tu puntaje es: $score/$maxScore',
                  style: TextStyle(
                      fontSize: 44,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: CircularProgressIndicator(
                        value: score /
                            maxScore, // Asegúrate de que este valor esté entre 0 y 1
                        strokeWidth: 10,
                        color: Colors.green,
                      ),
                    ),
                    Image.asset(
                      'assets/images/quijote.png',
                      width: 270,
                      height: 270,
                    ), // Asegúrate de reemplazar 'assets/images/your_image.png' con la ruta de tu imagen
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    SizedBox(width: 5),
                    Text('$stars Estrellas'),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.monetization_on, color: Colors.yellow),
                    SizedBox(width: 5),
                    Text('$coins Monedas'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
