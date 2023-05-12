import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class MapScreen extends Game {
  late ui.Image _backgroundImage;

  final List<Offset> points = [
    const Offset(125, 100),
    const Offset(200, 100),
    const Offset(250, 150),
    const Offset(350, 200),
    const Offset(450, 250),
    const Offset(525, 300),
    const Offset(450, 375),
    const Offset(350, 350),
    const Offset(250, 375),
    const Offset(150, 300),
  ];

  @override
  Future<void> onLoad() async {
    // Cargar la imagen de fondo
    final imageBytes = await rootBundle.load('images/map_background.jpg');
    _backgroundImage =
        await decodeImageFromList(imageBytes.buffer.asUint8List());
  }

  @override
  void update(double dt) {}

  @override
  void render(Canvas canvas) {
    canvas.drawImage(_backgroundImage, Offset.zero, Paint());

    // Dibuja los íconos de los puntos
    /* final paint = Paint()..color = const Color.fromARGB(255, 105, 30, 10);

    for (final point in points) {
      canvas.drawCircle(point, 10, paint);
    } */
    double iconSize = 20.0;
    Paint iconPaint = Paint()..color = const Color.fromARGB(255, 105, 30, 10);

    for (int i = 0; i < points.length; i++) {
      Offset point =
          Offset(points[i].dx - iconSize / 2, points[i].dy - iconSize / 2);
      canvas.drawCircle(point, iconSize / 2, iconPaint);
      TextSpan textSpan = TextSpan(
        text: (i + 1).toString(),
        style: const TextStyle(fontSize: 12, color: Colors.white),
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

    // Dibuja la línea punteada
    final path = Path();

    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final current = points[i];
      final distance = (current - prev).distance;
      final steps = (distance / 20).floor();
      final stepSize = (current - prev) / steps.toDouble();
      for (int j = 0; j < steps; j += 2) {
        final start = prev + (stepSize * j.toDouble());
        final end = start + stepSize;
        path.moveTo(start.dx, start.dy);
        path.lineTo(end.dx, end.dy);
      }
    }

    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true
      ..strokeJoin = StrokeJoin.round
      ..shader = const LinearGradient(
        colors: [
          Color.fromARGB(255, 105, 30, 10),
          Color.fromARGB(255, 105, 30, 10),
        ],
      ).createShader(Rect.fromPoints(points.first, points.last));
    canvas.drawPath(path, linePaint);
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
    canvas.drawCircle(center, radius,
        Paint()..color = const Color.fromARGB(255, 105, 30, 10));

    // Triángulo apuntando hacia abajo
    canvas.drawPath(path, Paint()..color = Colors.white);
  }
}
