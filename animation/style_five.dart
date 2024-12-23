import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(PlanetarySystemApp());
}

class PlanetarySystemApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlanetarySystemScreen(),
    );
  }
}

class PlanetarySystemScreen extends StatefulWidget {
  @override
  _PlanetarySystemScreenState createState() => _PlanetarySystemScreenState();
}

class _PlanetarySystemScreenState extends State<PlanetarySystemScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            painter: PlanetarySystemPainter(_controller.value),
          );
        },
      ),
    );
  }
}

class PlanetarySystemPainter extends CustomPainter {
  final double progress;
  PlanetarySystemPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw Background Gradient
    final bgPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.black, Colors.blueGrey.shade900],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Center of the solar system
    final center = Offset(size.width / 2, size.height / 2);

    // Draw Sun
    paint.color = Colors.yellow;
    canvas.drawCircle(center, 40, paint);

    // Define planetary data
    final List<Map<String, dynamic>> planets = [
      {'radius': 60.0, 'size': 10.0, 'color': Colors.grey}, // Mercury
      {'radius': 90.0, 'size': 12.0, 'color': Colors.orange}, // Venus
      {'radius': 120.0, 'size': 14.0, 'color': Colors.blue}, // Earth
      {'radius': 150.0, 'size': 12.0, 'color': Colors.red}, // Mars
      {'radius': 200.0, 'size': 20.0, 'color': Colors.brown}, // Jupiter
      {'radius': 250.0, 'size': 18.0, 'color': Colors.orangeAccent}, // Saturn
      {'radius': 300.0, 'size': 16.0, 'color': Colors.lightBlue}, // Uranus
      {'radius': 350.0, 'size': 16.0, 'color': Colors.deepPurple}, // Neptune
    ];

    // Draw planets
    for (int i = 0; i < planets.length; i++) {
      final double radius = planets[i]['radius'] as double;
      final double size = planets[i]['size'] as double;
      final Color color = planets[i]['color'] as Color;

      final angle = progress * 2 * pi * (1 + i * 0.1); // Vary speed by index
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      paint.color = color;
      canvas.drawCircle(Offset(x, y), size, paint);

      // Optional orbital paths
      paint.color = Colors.white.withOpacity(0.1);
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 1;
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(PlanetarySystemPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
