import 'package:flutter/material.dart';

void main() {
  runApp(MovingCloudsApp());
}

class MovingCloudsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovingCloudsScreen(),
    );
  }
}

class MovingCloudsScreen extends StatefulWidget {
  @override
  _MovingCloudsScreenState createState() => _MovingCloudsScreenState();
}

class _MovingCloudsScreenState extends State<MovingCloudsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
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
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 300),
            painter: MovingCloudsPainter(_controller.value),
          );
        },
      ),
    );
  }
}

class MovingCloudsPainter extends CustomPainter {
  final double progress;

  MovingCloudsPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    // Draw Sky Gradient
    final skyPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.lightBlueAccent, Colors.blueAccent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), skyPaint);

    // Draw Clouds
    final cloudSpeed1 = size.width * progress;
    final cloudSpeed2 = size.width * (progress + 0.3) % size.width;

    // Cloud 1
    canvas.drawCircle(Offset(cloudSpeed1 % size.width - 50, size.height * 0.3), 30, paint);
    canvas.drawCircle(Offset(cloudSpeed1 % size.width, size.height * 0.3), 40, paint);
    canvas.drawCircle(Offset(cloudSpeed1 % size.width + 50, size.height * 0.3), 30, paint);

    // Cloud 2
    canvas.drawCircle(Offset(cloudSpeed2 % size.width - 70, size.height * 0.5), 25, paint);
    canvas.drawCircle(Offset(cloudSpeed2 % size.width, size.height * 0.5), 35, paint);
    canvas.drawCircle(Offset(cloudSpeed2 % size.width + 70, size.height * 0.5), 25, paint);

    // Cloud 3 (slower)
    final cloudSpeed3 = size.width * (progress + 0.6) % size.width;
    canvas.drawCircle(Offset(cloudSpeed3 % size.width - 40, size.height * 0.7), 20, paint);
    canvas.drawCircle(Offset(cloudSpeed3 % size.width, size.height * 0.7), 30, paint);
    canvas.drawCircle(Offset(cloudSpeed3 % size.width + 40, size.height * 0.7), 20, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
