import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

alertaSimple(
    BuildContext context, String titulo, String subtitulo, String textoBoton) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (alertSimple) => AlertDialog(
              title: Text(titulo),
              content: Text(subtitulo),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(179, 91, 214, 1)),
                    child: Text(
                      textoBoton,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                    onPressed: () => SystemNavigator.pop())
              ],
            ));
  }
  showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text(titulo),
            content: Text(subtitulo),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(179, 91, 214, 1)),
                  child: Text(
                    textoBoton,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                  onPressed: () =>SystemNavigator.pop())
            ],
          ));
}
