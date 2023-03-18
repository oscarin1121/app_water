import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.size,
    required this.childButton,
    required this.colorButton,
    required this.function,
  }) : super(key: key);

  final Size size;
  final Widget childButton;
  final Color colorButton;
  final Function()? function;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: TextButton.styleFrom(
          backgroundColor: colorButton,
          shape: const StadiumBorder(),
          minimumSize: Size(size.width * 0.15, size.height * 0.04)),
      child: childButton,
    );
  }
}
