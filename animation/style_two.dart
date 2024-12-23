import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(WavingSailboatApp());
}

class WavingSailboatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WavingSailboatScreen(),
    );
  }
}

class WavingSailboatScreen extends StatefulWidget {
  @override
  _WavingSailboatScreenState createState() => _WavingSailboatScreenState();
}

class _WavingSailboatScreenState extends State<WavingSailboatScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
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
              size: Size(400, 300),
              painter: WavingSailboatPainter(_controller.value),
            );
          },
        ),
      ),
    );
  }
}

class WavingSailboatPainter extends CustomPainter {
  final double progress;

  WavingSailboatPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw Sky Gradient
    final skyPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.lightBlueAccent, Colors.blueAccent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), skyPaint);

    // Draw Waves
    final wavePath = Path();
    final waveHeight = 10;
    for (double i = 0; i <= size.width; i++) {
      final y = sin((i / size.width * 2 * pi) + (progress * 2 * pi)) * waveHeight + size.height * 0.8;
      if (i == 0) {
        wavePath.moveTo(i, y);
      } else {
        wavePath.lineTo(i, y);
      }
    }
    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();
    paint.color = Colors.blue;
    canvas.drawPath(wavePath, paint);

    // Draw Sailboat Body
    final sailboatX = size.width * 0.5;
    final sailboatY = size.height * 0.7 + sin(progress * 2 * pi) * waveHeight;
    final sailboatBody = Path()
      ..moveTo(sailboatX - 30, sailboatY)
      ..lineTo(sailboatX + 30, sailboatY)
      ..lineTo(sailboatX, sailboatY + 20)
      ..close();
    paint.color = Colors.brown;
    canvas.drawPath(sailboatBody, paint);

    // Draw Sail
    final sail = Path()
      ..moveTo(sailboatX, sailboatY)
      ..lineTo(sailboatX, sailboatY - 50)
      ..lineTo(sailboatX + 40, sailboatY)
      ..close();
    paint.color = Colors.white;
    canvas.drawPath(sail, paint);

    // Draw Mast
    paint.color = Colors.black;
    paint.strokeWidth = 2;
    canvas.drawLine(Offset(sailboatX, sailboatY), Offset(sailboatX, sailboatY - 50), paint);

    // Draw Sun
    paint.color = Colors.yellow;
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), 30, paint);

    // Add Birds
    final birdPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (int i = 0; i < 3; i++) {
      final birdX = size.width * 0.2 * (i + 1);
      final birdY = size.height * 0.2;
      final birdPath = Path()
        ..moveTo(birdX, birdY)
        ..relativeLineTo(-10, -10)
        ..moveTo(birdX, birdY)
        ..relativeLineTo(10, -10);
      canvas.drawPath(birdPath, birdPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
