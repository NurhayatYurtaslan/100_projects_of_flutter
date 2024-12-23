import 'package:flutter/material.dart';

void main() {
  runApp(HologramMaskApp());
}

class HologramMaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HologramMaskScreen(),
    );
  }
}

class HologramMaskScreen extends StatefulWidget {
  @override
  _HologramMaskScreenState createState() => _HologramMaskScreenState();
}

class _HologramMaskScreenState extends State<HologramMaskScreen> {
  double _sliderValue = 0;

  List<String> _feedbackTexts = ["Calm", "Focused", "Energized", "Excited", "Joyful"];
  List<List<Color>> _hologramColors = [
    [Colors.blue.withOpacity(0.8), Colors.cyan.withOpacity(0.8)],
    [Colors.purple.withOpacity(0.8), Colors.pink.withOpacity(0.8)],
    [Colors.orange.withOpacity(0.8), Colors.redAccent.withOpacity(0.8)],
    [Colors.yellow.withOpacity(0.8), Colors.orange.withOpacity(0.8)],
    [Colors.green.withOpacity(0.8), Colors.lightGreenAccent.withOpacity(0.8)],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _hologramColors[_sliderValue.toInt()],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPaint(
                size: Size(300, 300),
                painter: HologramMaskPainter(_sliderValue),
              ),
              SizedBox(height: 20),
              Text(
                _feedbackTexts[_sliderValue.toInt()],
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HologramMaskPainter extends CustomPainter {
  final double intensity;

  HologramMaskPainter(this.intensity);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Yüz (Hologram Efekti)
    paint.shader = LinearGradient(
      colors: [Colors.white.withOpacity(0.6), Colors.white.withOpacity(0.9)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );

    // Gözler (Hologram Geometrisi)
    paint.color = Colors.cyanAccent.withOpacity(0.9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * 0.3, size.height * 0.4),
          width: 70,
          height: 35,
        ),
        Radius.circular(12),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * 0.7, size.height * 0.4),
          width: 70,
          height: 35,
        ),
        Radius.circular(12),
      ),
      paint,
    );

    // Ağız (Holografik Çizgi)
    paint.color = Colors.orangeAccent.withOpacity(0.9);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    final path = Path();
    path.moveTo(size.width * 0.3, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.7 + intensity * 15,
      size.width * 0.7, size.height * 0.7,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
