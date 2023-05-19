// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'map.dart';
import 'nivel1.dart';

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
    var containerWidth = MediaQuery.of(context).size.width;
    var containerHeight = MediaQuery.of(context).size.height;
    var backgroundImageFit = BoxFit.cover;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EL QUIJOTE DE LA MANCHA',
          style: TextStyle(fontFamily: 'Alegreya', fontSize: 24),
        ),
        backgroundColor: Colors.brown,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 14),
            child: Row(
              children: [
                Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.amber,
                ),
                SizedBox(width: 5),
                Text(
                  '$_monedas',
                  style: TextStyle(
                    fontFamily: 'Alegreya',
                    fontSize: 40,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: containerWidth.toDouble(),
          height: containerHeight.toDouble(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/pergamino.png"),
              fit: backgroundImageFit,
            ),
          ),
          child: PageView.builder(
            itemCount: niveles.length,
            // imagen a cambiar
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: NivelCard(
                  nivel: 'Nivel ${index + 1}',
                  imagen: imagenesNiveles[index],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.brown,
        child: Container(
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Tienda()),
                  // );
                },
                icon: Icon(Icons.store),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Inventario()),
                },
                icon: Icon(Icons.inventory),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Perfil()),
                },
                //icono de perfil
                icon: Icon(Icons.person),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: backgroundImageFit == BoxFit.cover
          ? Color.fromRGBO(195, 144, 50, 1.5)
          : Colors.white,
      //boton flotante del mapa
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapScreen()),
            );
          },
          child: Icon(Icons.map),
          backgroundColor: Colors.brown,
        ),
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

class _NivelCardState extends State<NivelCard>
    with SingleTickerProviderStateMixin {
  bool _mostrarDificultades = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDificultades() {
    setState(() {
      _mostrarDificultades = !_mostrarDificultades;
      if (_mostrarDificultades) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 500,
        height: 500,
        child: Stack(
          children: [
            Positioned.fill(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
                color: Colors.transparent,
                child: Image.asset(
                  widget.imagen,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            //boton de play como barra de navegacion en el fondo que muestre las dificultades del nivel
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _toggleDificultades,
                    child: Text('Jugar\n ${widget.nivel}'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SlideTransition(
              position: _offsetAnimation,
              child:
                  _mostrarDificultades ? _DificultadesWidget() : _nivelWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nivelWidget() {
    return Center(child: Text(widget.nivel));
  }
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(),
                ),
              );
            },
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
