import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(RainAnimationApp());
}

class RainAnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RainAnimationScreen(),
    );
  }
}

class RainAnimationScreen extends StatefulWidget {
  @override
  _RainAnimationScreenState createState() => _RainAnimationScreenState();
}

class _RainAnimationScreenState extends State<RainAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
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
      backgroundColor: Colors.blueGrey,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            painter: RainPainter(_controller.value),
          );
        },
      ),
    );
  }
}

class RainPainter extends CustomPainter {
  final double progress;
  RainPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.8);
    final splashPaint = Paint()..color = Colors.white.withOpacity(0.6);
    final random = Random();
    final int dropCount = 100;

    for (int i = 0; i < dropCount; i++) {
      final x = random.nextDouble() * size.width;
      final y = (progress * size.height + i * 15) % size.height;
      final dropLength = random.nextDouble() * 10 + 10;

      // Draw raindrop
      canvas.drawLine(
        Offset(x, y),
        Offset(x, y + dropLength),
        paint,
      );

      // Draw splash effect when the drop reaches the bottom
      if (y + dropLength > size.height - 10) {
        canvas.drawCircle(Offset(x, size.height - 10), 3, splashPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant RainPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
