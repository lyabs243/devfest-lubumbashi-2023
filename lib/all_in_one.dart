import 'dart:math';
import 'dart:ui' as ui;

import 'package:devfest_lushi_2023/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class AllInOneTest extends StatelessWidget {
  const AllInOneTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double squareSize = MediaQuery.of(context).size.height / 1.8;

    return Scaffold(
      appBar: AppBar(title: const Text('All In One Test')),
      body: Center(
        child: Container(
          width: squareSize,
          height: squareSize,
          padding: const EdgeInsets.all(pagePadding),
          child: const AnalogClock(),
        ),
      ),
    );
  }
}

class AnalogClock extends StatefulWidget {
  const AnalogClock({Key? key}) : super(key: key);

  @override
  State<AnalogClock> createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock>
  with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late final Animation<double> _anAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    ) ..repeat(reverse: false);
    _anAnimation = Tween<double>(
        begin: 0,
        end: 1
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _anAnimation,
      child: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.6,
              child: LottieBuilder.asset('assets/weather.json'),
            )
          )
        ],
      ),
      builder: (context, child) {
        return CustomPaint(
          painter: AnalogClockPainter(),
          child: child,
        );
      },
    );
  }

}

class AnalogClockPainter extends CustomPainter {

  DateTime _datetime = DateTime.now();

  AnalogClockPainter();

  @override
  void paint(Canvas canvas, Size size) {

    _datetime = DateTime.now();

    // a square container
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // draw devfest circles in the square
    int lineIndex = 0, columnIndex = 0;
    while (lineIndex < 5) {

      while (columnIndex < 5) {
        drawDevFestCircle(canvas:  canvas, size: const Size(100, 100),
            lineIndex: lineIndex, columnIndex: columnIndex);
        columnIndex++;
      }
      columnIndex = 0;
      lineIndex++;
    }

    // draw the clock
    final radius = size.width / 2;
    final double borderWidth = radius / 20.0;

    final paint2 = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint2);

    canvas.translate(size.width / 2, size.height / 2);

    double maxRadius = 150;
    double maxStroke = 6;
    _paintHourHand(canvas, maxRadius / 2.5, maxStroke);
    _paintMinuteHand(canvas, maxRadius / 1.6, maxStroke / 1.4);
    _paintSecondHand(canvas, maxRadius / 1.4, maxStroke / 3);

    //drawing center point
    Paint centerPointPaint = Paint()
      ..strokeWidth = ((radius - borderWidth) / 10)
      ..strokeCap = StrokeCap.round
      ..color = Colors.black;
    canvas.drawPoints(ui.PointMode.points, const [Offset(0, 0)], centerPointPaint);

    // draw the clock numbers
    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (int i = 1; i <= 12; i++) {

      int index = (i + 3) % 12;
      if (index == 0) index = 12;

      textPainter.text = TextSpan(
        text: '$index',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      double angle = i * 30.0;
      double x = cos(getRadians(angle)) * (radius - 30) - textPainter.width / 2;
      double y = sin(getRadians(angle)) * (radius - 30) - textPainter.height / 2;
      textPainter.paint(canvas, Offset(x, y));
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  /// drawing hour hand
  void _paintHourHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.hour % 12 + _datetime.minute / 60.0 - 3;
    Offset handOffset = Offset(cos(getRadians(angle * 30)) * radius,
        sin(getRadians(angle * 30)) * radius);
    final handPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth;
    canvas.drawLine(const Offset(0, 0), handOffset, handPaint);
  }

  /// drawing minute hand
  void _paintMinuteHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.minute - 15.0;
    Offset handOffset = Offset(cos(getRadians(angle * 6.0)) * radius,
        sin(getRadians(angle * 6.0)) * radius);
    final handPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth;
    canvas.drawLine(const Offset(0, 0), handOffset, handPaint);
  }

  /// drawing second hand
  void _paintSecondHand(Canvas canvas, double radius, double strokeWidth) {

    double angle = _datetime.second - 15.0;
    Offset handOffset = Offset(cos(getRadians(angle * 6.0)) * radius,
        sin(getRadians(angle * 6.0)) * radius);
    final handPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = strokeWidth;
    canvas.drawLine(const Offset(0, 0), handOffset, handPaint);
  }

  static double getRadians(double angle) {
    return angle * pi / 180;
  }

  //draw a circle with horizontal and vertical lines
  void drawDevFestCircle({
    required Canvas canvas,
    required Size size,
    required int lineIndex,
    required int columnIndex}) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Offset point = Offset(columnIndex * size.width, lineIndex * size.height);
    canvas.drawCircle(point, size.width / 2, paint);

  }

}