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
        title: Text(
          'EL QUIJOTE DE LA MANCHA',
          style: TextStyle(fontFamily: 'Alegreya', fontSize: 24),
        ),
        backgroundColor: Colors.brown,
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  widget.imagen,
                  fit: BoxFit.contain,
                ),
              ),
              _mostrarDificultades ? _DificultadesWidget() : _nivelWidget(),
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
  // Widget _dificultadesWidget() {
  //   List<String> dificultades = ['Fácil', 'Intermedio', 'Difícil'];
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: dificultades
  //         .map(
  //           (dificultad) => Container(
  //             alignment: Alignment(0, 0),
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 // Navega al nivel y dificultad seleccionados
  //               },
  //               child: Text(dificultad),
  //             ),
  //           ),
  //         )
  //         .toList(),
  //   );
  // }
}

class _DificultadesWidget extends StatefulWidget {
  const _DificultadesWidget({Key? key}) : super(key: key);

  @override
  _DificultadesWidgetState createState() => _DificultadesWidgetState();
}

class _DificultadesWidgetState extends State<_DificultadesWidget> {
  List<Map<String, dynamic>> dificultades = [
    {'nombre': 'Fácil', 'progreso': 50},
    {'nombre': 'Intermedio', 'progreso': 25},
    {'nombre': 'Difícil', 'progreso': 10}
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: dificultades
            .map(
              (dificultad) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return DificultadDetalleWidget(
                        nombre: dificultad['nombre'],
                        progreso: dificultad['progreso'],
                      );
                    },
                  );
                },
                child: Text(dificultad['nombre']),
              ),
            )
            .toList(),
      ),
    );
  }
}

class DificultadDetalleWidget extends StatefulWidget {
  final String nombre;
  final int progreso;

  const DificultadDetalleWidget({
    Key? key,
    required this.nombre,
    required this.progreso,
  }) : super(key: key);

  @override
  _DificultadDetalleWidgetState createState() =>
      _DificultadDetalleWidgetState();
}

class _DificultadDetalleWidgetState extends State<DificultadDetalleWidget> {
  bool mostrarProgreso = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.all(5)),
          Text("Progreso del nivel ${widget.nombre}: ${widget.progreso}%",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis),
          Padding(padding: EdgeInsets.all(5)),
          SizedBox(
            width: 250,
            height: 20, // Máximo ancho de la barra de progreso
            child: LinearProgressIndicator(
              value: widget.progreso / 100,
              minHeight: 10, // Altura de la barra de progreso
              backgroundColor:
                  Colors.grey[300], // Color de fondo de la barra de progreso
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.green), // Color de la barra de progreso
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          ElevatedButton(
            onPressed: () {},
            child: Text('Iniciar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Volver'),
          ),
        ],
      ),
    );
  }
}
