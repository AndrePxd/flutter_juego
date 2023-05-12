import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapa del Quijote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa del Quijote'),
      ),
      body: Center(
        child: CustomPaint(
          painter: MapPainter(),
          size: Size(300, 300),
        ),
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Dibujar línea punteada
    Paint linePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    List<Offset> points = [
      Offset(0.1, 0.1),
      Offset(0.4, 0.4),
      Offset(0.6, 0.2),
      Offset(0.8, 0.3),
      Offset(0.9, 0.6),
      Offset(0.7, 0.8),
      Offset(0.5, 0.7),
      Offset(0.3, 0.9),
      Offset(0.2, 0.6),
      Offset(0.1, 0.5),
    ];

    // Dibujar línea punteada
    Path path = Path();
    path.moveTo(points[0].dx * size.width, points[0].dy * size.height);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx * size.width, points[i].dy * size.height);
    }

    canvas.drawPath(path, linePaint);

    // Dibujar iconos de ubicación
    IconData locationIcon = Icons.location_on;
    double iconSize = 20.0;
    Paint iconPaint = Paint()..color = Colors.red;

    for (int i = 0; i < points.length; i++) {
      Offset point =
          Offset(points[i].dx * size.width, points[i].dy * size.height);
      canvas.drawCircle(point, iconSize / 2, iconPaint);
      TextSpan textSpan = TextSpan(
        text: (i + 1).toString(),
        style: TextStyle(fontSize: 12, color: Colors.white),
      );
      TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(point.dx - textPainter.width / 2,
              point.dy - textPainter.height / 2));
      drawLocationIcon(canvas, point, iconSize);
    }
  }

  void drawLocationIcon(Canvas canvas, Offset center, double size) {
    Path path = Path();
    double radius = size / 2;
    double triangleHeight = size * 0.3;

    // Triángulo apuntando hacia arriba
    path.moveTo(center.dx, center.dy - radius);
    path.lineTo(center.dx - triangleHeight, center.dy + radius);
    path.lineTo(center.dx + triangleHeight, center.dy + radius);
    path.close();

    // Círculo del icono de ubicación
    canvas.drawCircle(center, radius, Paint()..color = Colors.red);

    // Triángulo apuntando hacia abajo
    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
