import 'dart:math';

import 'package:flutter/material.dart';

class CloudWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _ClouidWidgetPaint(),
      ),
    );
  }
}

class _ClouidWidgetPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint();
    //Propiedades
    paintLine.color = Color(0xff67739A);
    paintLine.style = PaintingStyle.fill; //.fill
    paintLine.strokeWidth = 2;
    final path = Path();
    //Dibujar con el path y el lapiz
    path.moveTo(size.width * 0.25, size.height * 0.5);
    path.lineTo(size.width * 0.75, size.height * 0.5);
    path.lineTo(size.width * 0.75, size.height * 0.40);
    path.lineTo(size.width * 0.25, size.height * 0.40);
    canvas.drawPath(path, paintLine);

    final paintCircleOne = Paint();
    paintCircleOne.color = Color(0xff67739A);
    paintCircleOne.style = PaintingStyle.fill; //.fill
    paintCircleOne.strokeWidth = 2;
    Offset center = Offset(size.width * 0.25, size.height * 0.42);
    double radio = min(size.width * 0.15, size.height * 0.15);

    canvas.drawCircle(center, radio, paintCircleOne);
    final paintCircletwo = Paint();
    paintCircletwo.color = Color(0xff67739A);
    paintCircletwo.style = PaintingStyle.fill; //.fill
    paintCircletwo.strokeWidth = 2;
    center = Offset(size.width * 0.5, size.height * 0.365);
    radio = min(size.width * 0.25, size.height * 0.25);

    canvas.drawCircle(center, radio, paintCircletwo);

    final paintCirclethree = Paint();
    paintCirclethree.color = Color(0xff67739A);
    paintCirclethree.style = PaintingStyle.fill; //.fill
    paintCirclethree.strokeWidth = 2;
    center = Offset(size.width * 0.75, size.height * 0.42);
    radio = min(size.width * 0.15, size.height * 0.15);

    canvas.drawCircle(center, radio, paintCirclethree);
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }
}
