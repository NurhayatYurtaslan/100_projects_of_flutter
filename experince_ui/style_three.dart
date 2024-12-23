import 'package:flutter/material.dart';

void main() {
  runApp(MinimalistFaceApp());
}

class MinimalistFaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MinimalistFaceScreen(),
    );
  }
}

class MinimalistFaceScreen extends StatefulWidget {
  @override
  _MinimalistFaceScreenState createState() => _MinimalistFaceScreenState();
}

class _MinimalistFaceScreenState extends State<MinimalistFaceScreen> {
  double _sliderValue = 0;

  List<String> _feedbackTexts = ["Sad", "Neutral", "Happy"];
  List<Color> _feedbackColors = [Colors.red, Colors.orange, Colors.green];
  List<double> _mouthCurves = [-20, 0, 20];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _feedbackColors[_sliderValue.toInt()],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              size: Size(200, 200),
              painter: MinimalistFacePainter(_mouthCurves[_sliderValue.toInt()]),
            ),
            SizedBox(height: 20),
            Text(
              _feedbackTexts[_sliderValue.toInt()],
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 2,
              divisions: 2,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MinimalistFacePainter extends CustomPainter {
  final double mouthCurve;

  MinimalistFacePainter(this.mouthCurve);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Gözler
    canvas.drawRect(
      Rect.fromCenter(
          center: Offset(size.width * 0.3, size.height * 0.4), width: 30, height: 10),
      paint,
    );
    canvas.drawRect(
      Rect.fromCenter(
          center: Offset(size.width * 0.7, size.height * 0.4), width: 30, height: 10),
      paint,
    );

    // Ağız
    final path = Path();
    path.moveTo(size.width * 0.3, size.height * 0.7);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.7 + mouthCurve, size.width * 0.7, size.height * 0.7);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
