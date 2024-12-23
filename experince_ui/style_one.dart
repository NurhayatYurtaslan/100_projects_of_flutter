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

  List<IconData> _feedbackIcons = [
    Icons.sentiment_very_dissatisfied,
    Icons.sentiment_dissatisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_satisfied,
    Icons.sentiment_very_satisfied,
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
            Icon(
              _feedbackIcons[_sliderValue.toInt()],
              color: Colors.white,
              size: 100,
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
