import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(GrowingTreeApp());
}

class GrowingTreeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GrowingTreeScreen(),
    );
  }
}

class GrowingTreeScreen extends StatefulWidget {
  @override
  _GrowingTreeScreenState createState() => _GrowingTreeScreenState();
}

class _GrowingTreeScreenState extends State<GrowingTreeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            painter: GrowingTreePainter(_controller.value),
          );
        },
      ),
    );
  }
}

class GrowingTreePainter extends CustomPainter {
  final double progress;
  GrowingTreePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final leafPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    // Draw trunk
    final trunkStart = Offset(size.width / 2, size.height);
    final trunkEnd = Offset(size.width / 2, size.height * (1 - progress * 0.3));
    canvas.drawLine(trunkStart, trunkEnd, paint);

    // Draw branches and leaves
    _drawBranch(canvas, trunkEnd, -pi / 2, progress, paint, leafPaint, depth: 0);
  }

  void _drawBranch(Canvas canvas, Offset start, double angle, double progress, Paint branchPaint, Paint leafPaint, {int depth = 0}) {
    if (depth > 5 || progress < 0.1) return;

    final branchLength = 100.0 * pow(0.7, depth) * progress;
    final end = Offset(
      start.dx + branchLength * cos(angle),
      start.dy + branchLength * sin(angle),
    );

    canvas.drawLine(start, end, branchPaint);

    if (depth > 2 && progress > 0.7) {
      canvas.drawCircle(end, 5, leafPaint);
    }

    _drawBranch(canvas, end, angle - pi / 6, progress - 0.1, branchPaint, leafPaint, depth: depth + 1);
    _drawBranch(canvas, end, angle + pi / 6, progress - 0.1, branchPaint, leafPaint, depth: depth + 1);
  }

  @override
  bool shouldRepaint(covariant GrowingTreePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
