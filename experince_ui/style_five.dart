import 'package:flutter/material.dart';

void main() {
  runApp(EmojiFaceApp());
}

class EmojiFaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmojiFaceScreen(),
    );
  }
}

class EmojiFaceScreen extends StatefulWidget {
  @override
  _EmojiFaceScreenState createState() => _EmojiFaceScreenState();
}

class _EmojiFaceScreenState extends State<EmojiFaceScreen> {
  double _sliderValue = 0;

  List<String> _feedbackTexts = ["Sad", "Neutral", "Happy"];
  List<List<Color>> _gradientColors = [
    [Colors.red, Colors.deepOrange],
    [Colors.orange, Colors.yellow],
    [Colors.green, Colors.lightGreenAccent],
  ];
  List<double> _mouthCurves = [-30, 0, 30];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _gradientColors[_sliderValue.toInt()],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPaint(
                size: Size(200, 200),
                painter: EmojiFacePainter(_mouthCurves[_sliderValue.toInt()]),
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
      ),
    );
  }
}

class EmojiFacePainter extends CustomPainter {
  final double mouthCurve;

  EmojiFacePainter(this.mouthCurve);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    // Yüz (Büyük daire)
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );

    // Gözler
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.4),
      20,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.4),
      20,
      paint,
    );

    // Göz Bebekleri
    paint.color = Colors.black;
    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.4),
      8,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.4),
      8,
      paint,
    );

    // Ağız
    final path = Path();
    path.moveTo(size.width * 0.3, size.height * 0.7);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.7 + mouthCurve, size.width * 0.7, size.height * 0.7);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;
    canvas.drawPath(path, paint);

    // Glow Effect for Eyes
    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.4),
      30,
      glowPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.4),
      30,
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
