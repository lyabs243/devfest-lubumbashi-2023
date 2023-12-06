import 'package:devfest_lushi_2023/utils.dart';
import 'package:flutter/material.dart';

class CustomPainterTest extends StatelessWidget {

  const CustomPainterTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Painter Test')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(pagePadding),
        child: const HousePaint(),
      ),
    );
  }

}

class HousePaint extends StatelessWidget {
  const HousePaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HousePainter(),
    );
  }
}

class HousePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    // the roof
    final paintRoof = Paint()
      ..color = Colors.brown
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    double roofHeight = size.height / 3;
    final path = Path()
      ..moveTo(0, roofHeight)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, roofHeight)
      ..close();

    canvas.drawPath(path, paintRoof);

    // the chimney (la cheminée)
    final paintChimney = Paint()
      ..color = Colors.brown
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    double chimneyWidth = size.width / 10;
    double chimneyHeight = size.height / 4;
    double chimneyCenterX = size.width / 1.2;
    double chimneyCenterY = roofHeight / 2;

    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(chimneyCenterX, chimneyCenterY),
          width: chimneyWidth,
          height: chimneyHeight,
        ),
        paintChimney
    );

    // the house
    final paintHouse = Paint()
      ..color = Colors.brown
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double paddingFromRoof = size.width / 10;
    final pathHouse = Path()
      ..moveTo(paddingFromRoof, roofHeight)
      ..lineTo(paddingFromRoof, size.height)
      ..lineTo(size.width - paddingFromRoof, size.height)
      ..lineTo(size.width - paddingFromRoof, roofHeight)
      ..close();

    canvas.drawPath(pathHouse, paintHouse);

    // the door
    final paintDoor = Paint()
      ..color = Colors.brown
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    double doorWidth = size.width / 3.5;
    double doorHeight = size.height / 2.8;
    double doorCenterX = size.width / 2;
    double doorCenterY = size.height - doorHeight / 2;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(doorCenterX, doorCenterY),
        width: doorWidth,
        height: doorHeight,
      ),
      paintDoor
    );

    // the door knob (la poignée de la porte)
    final paintDoorKnob = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    double doorKnobRadius = 10;
    canvas.drawCircle(Offset(size.width / 2 + doorWidth / 2 - (doorKnobRadius + 8), size.height - doorHeight / 2), doorKnobRadius, paintDoorKnob);

    // the window
    final paintWindow = Paint()
      ..color = Colors.brown
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    double windowWidth = size.width / 4.5;
    double windowHeight = size.height / 5.5;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width - paddingFromRoof - 20 - (windowWidth / 2), roofHeight + 20 + (windowHeight / 2)),
        width: windowWidth,
        height: windowHeight,
      ),
      paintWindow
    );

    // the window panes (les carreaux de la fenêtre)
    final paintWindowPanes = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width - paddingFromRoof - 20 - (windowWidth / 2), roofHeight + 20),
      Offset(size.width - paddingFromRoof - 20 - (windowWidth / 2), roofHeight + 20 + windowHeight),
      paintWindowPanes
    );

    canvas.drawLine(
      Offset(size.width - paddingFromRoof - 20 - (windowWidth / 2) - (windowWidth / 2), roofHeight + 20 + (windowHeight / 2)),
      Offset(size.width - paddingFromRoof - 20 - (windowWidth / 2) + (windowWidth / 2), roofHeight + 20 + (windowHeight / 2)),
      paintWindowPanes
    );


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}