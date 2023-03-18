import 'dart:math';

import 'package:flutter/material.dart';

class CircleHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _CircleHomePainter(),
      ),
    );
  }
}

class _CircleHomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    //Propiedades
    DateTime dateTime = DateTime.now();
    print(dateTime.hour);
    final checkColor = dateTime.hour >= 20 || dateTime.hour <= 6;
    final Rect rect = Rect.fromCircle(center: Offset(250, 250), radius: 180);

    final Gradient gradiente = LinearGradient(
        colors: <Color>[
          checkColor ? Color(0xffBCB9AF) : Color(0xffFFBB7C),
          checkColor ? Color(0xffFAF8F4) : Color(0xffFF61A1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [
          0.2,
          1,
        ]);

    paint.style = PaintingStyle.fill; //.fill
    paint.strokeWidth = 2;
    final path = Path();
    //Dibujar con el path y el lapiz
    path.moveTo(size.width, 0);
    paint.shader = gradiente.createShader(rect);
    Offset center = Offset(size.width * 0.95, size.height * 0.1);
    double radio = min(size.width * 0.4, size.height * 0.4);

    canvas.drawCircle(center, radio, paint);

    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }
}
