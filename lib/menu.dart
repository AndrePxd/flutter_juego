import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  int _monedas = 0;
  List<String> niveles = [
    'Nivel 1',
    'Nivel 2',
    'Nivel 3',
    'Nivel 4',
    'Nivel 5',
    'Nivel 6',
    'Nivel 7',
    'Nivel 8',
    'Nivel 9'
  ];
  final List<String> imagenesNiveles = [
    'assets/images/niv1.jpg',
    'assets/images/niv1.jpg',
    'assets/images/niv1.jpg',
    'assets/images/niv1.jpg',
    'assets/images/niv1.jpg',
    'assets/images/niv1.jpg',
    'assets/images/niv1.jpg',
    'assets/images/niv1.jpg',
    'assets/images/niv1.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EL QUIJOTE DE LA MANCHA'),
        actions: [
          Row(
            children: [
              Icon(Icons.monetization_on_outlined),
              SizedBox(width: 8),
              Text('$_monedas'),
            ],
          ),
          SizedBox(width: 16),
        ],
      ),
      body: PageView.builder(
        itemCount: niveles.length,
        itemBuilder: (BuildContext context, int index) {
          return NivelCard(
            nivel: 'Nivel ${index + 1}',
            imagen: imagenesNiveles[index],
          );
        },
      ),
    );
  }
}

class NivelCard extends StatefulWidget {
  final String nivel;
  final String imagen;

  NivelCard({required this.nivel, required this.imagen});

  @override
  _NivelCardState createState() => _NivelCardState();
}

class _NivelCardState extends State<NivelCard> {
  bool _mostrarDificultades = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.75,
        child: Card(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  widget.imagen,
                  fit: BoxFit.contain,
                ),
              ),
              _mostrarDificultades ? _dificultadesWidget() : _nivelWidget(),
              Positioned(
                left: 0,
                right: 0,
                bottom: 16,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _mostrarDificultades = !_mostrarDificultades;
                    });
                  },
                  child: Icon(Icons.play_arrow),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nivelWidget() {
    return Center(child: Text(widget.nivel));
  }

  Widget _dificultadesWidget() {
    List<String> dificultades = ['Fácil', 'Intermedio', 'Difícil'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: dificultades
          .map(
            (dificultad) => Container(
              alignment: Alignment(0, 0),
              child: ElevatedButton(
                onPressed: () {
                  // Navega al nivel y dificultad seleccionados
                },
                child: Text(dificultad),
              ),
            ),
          )
          .toList(),
    );
  }
}
