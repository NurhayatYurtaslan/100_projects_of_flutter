import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(FlyingBirdsLoadingApp());
}

class FlyingBirdsLoadingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlyingBirdsLoadingScreen(),
    );
  }
}

class FlyingBirdsLoadingScreen extends StatefulWidget {
  @override
  _FlyingBirdsLoadingScreenState createState() => _FlyingBirdsLoadingScreenState();
}

class _FlyingBirdsLoadingScreenState extends State<FlyingBirdsLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
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
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size(400, 200),
              painter: FlyingBirdsPainter(_controller.value),
            );
          },
        ),
      ),
    );
  }
}

class FlyingBirdsPainter extends CustomPainter {
  final double progress;

  FlyingBirdsPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final birdCount = 5;
    final birdSpacing = size.width / birdCount;
    final wingMovement = sin(progress * 2 * pi) * 20;

    for (int i = 0; i < birdCount; i++) {
      final birdX = i * birdSpacing + birdSpacing / 2;
      final birdY = size.height / 2 - (i.isEven ? wingMovement : -wingMovement);

      // Left Wing
      final leftWing = Path()
        ..moveTo(birdX, birdY)
        ..lineTo(birdX - 20, birdY - 20)
        ..lineTo(birdX, birdY);

      // Right Wing
      final rightWing = Path()
        ..moveTo(birdX, birdY)
        ..lineTo(birdX + 20, birdY - 20)
        ..lineTo(birdX, birdY);

      canvas.drawPath(leftWing, paint);
      canvas.drawPath(rightWing, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
