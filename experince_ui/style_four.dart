import 'package:flutter/material.dart';

void main() {
  runApp(CartoonFaceApp());
}

class CartoonFaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartoonFaceScreen(),
    );
  }
}

class CartoonFaceScreen extends StatefulWidget {
  @override
  _CartoonFaceScreenState createState() => _CartoonFaceScreenState();
}

class _CartoonFaceScreenState extends State<CartoonFaceScreen> {
  double _sliderValue = 0;

  List<String> _feedbackTexts = ["Sad", "Neutral", "Happy"];
  List<Color> _feedbackColors = [Colors.red, Colors.orange, Colors.green];
  List<double> _mouthCurves = [-20, 0, 20];
  List<double> _eyeOffsets = [-5, 0, 5];

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
              painter: CartoonFacePainter(
                _mouthCurves[_sliderValue.toInt()],
                _eyeOffsets[_sliderValue.toInt()],
              ),
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

class CartoonFacePainter extends CustomPainter {
  final double mouthCurve;
  final double eyeOffset;

  CartoonFacePainter(this.mouthCurve, this.eyeOffset);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Gözler
    canvas.drawCircle(
      Offset(size.width * 0.3 + eyeOffset, size.height * 0.4),
      15,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.7 + eyeOffset, size.height * 0.4),
      15,
      paint,
    );

    // Göz Bebekleri
    paint.color = Colors.black;
    canvas.drawCircle(
      Offset(size.width * 0.3 + eyeOffset, size.height * 0.4),
      5,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.7 + eyeOffset, size.height * 0.4),
      5,
      paint,
    );

    // Kaşlar (Daha yukarıda)
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.3),
      Offset(size.width * 0.4, size.height * 0.3),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.6, size.height * 0.3),
      Offset(size.width * 0.8, size.height * 0.3),
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

    // Dil
    if (mouthCurve > 0) {
      paint.color = Colors.red;
      paint.style = PaintingStyle.fill;
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.75),
          width: 30,
          height: 15,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
