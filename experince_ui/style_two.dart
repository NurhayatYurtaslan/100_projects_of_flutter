import 'package:flutter/material.dart';

void main() {
  runApp(ExperienceSliderApp());
}

class ExperienceSliderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExperienceSliderScreen(),
    );
  }
}

class ExperienceSliderScreen extends StatefulWidget {
  @override
  _ExperienceSliderScreenState createState() => _ExperienceSliderScreenState();
}

class _ExperienceSliderScreenState extends State<ExperienceSliderScreen> {
  double _sliderValue = 0;

  List<String> _feedbackTexts = [
    "Very Poor",
    "Poor",
    "Below Average",
    "Above Average",
    "Excellent",
  ];

  List<Color> _feedbackColors = [
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.green,
  ];

  List<FaceExpression> _faceExpressions = [
    FaceExpression(-15, 15, 5), // Very Poor
    FaceExpression(-10, 10, 10), // Poor
    FaceExpression(-5, 5, 20), // Below Average
    FaceExpression(0, 0, 30), // Above Average
    FaceExpression(5, -5, 50), // Excellent
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _feedbackColors[_sliderValue.toInt()],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "How Was Your Experience?",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CustomPaint(
              size: Size(200, 200),
              painter: FacePainter(_faceExpressions[_sliderValue.toInt()]),
            ),
            SizedBox(height: 20),
            Text(
              _feedbackTexts[_sliderValue.toInt()],
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 4,
              divisions: 4,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
              activeColor: Colors.white,
              inactiveColor: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}

class FaceExpression {
  final double leftEyeX; // Sol göz kayması
  final double rightEyeX; // Sağ göz kayması
  final double mouthCurve; // Ağız eğriliği

  FaceExpression(this.leftEyeX, this.rightEyeX, this.mouthCurve);
}

class FacePainter extends CustomPainter {
  final FaceExpression faceExpression;

  FacePainter(this.faceExpression);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Göz boyutları
    double eyeRadius = size.width * 0.08;

    // Sol Göz
    canvas.drawCircle(
      Offset(size.width * 0.3 + faceExpression.leftEyeX, size.height * 0.4),
      eyeRadius,
      paint,
    );

    // Sağ Göz
    canvas.drawCircle(
      Offset(size.width * 0.7 + faceExpression.rightEyeX, size.height * 0.4),
      eyeRadius,
      paint,
    );

    // Ağız
    final mouthPath = Path();
    mouthPath.moveTo(size.width * 0.3, size.height * 0.7);
    mouthPath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.7 + faceExpression.mouthCurve,
      size.width * 0.7,
      size.height * 0.7,
    );
    mouthPath.lineTo(size.width * 0.7, size.height * 0.7 + 2); // Çizgi kalınlığı
    mouthPath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.7 + faceExpression.mouthCurve + 2,
      size.width * 0.3,
      size.height * 0.7 + 2,
    );
    mouthPath.close();

    paint.color = Colors.white;
    canvas.drawPath(mouthPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
