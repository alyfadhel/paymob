import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double width;
  final Color background;
  final double radius;
  final Function() onPressed;
  final String text;
  final bool isUpperCase;
  final TextStyle? style;

  const MyButton({
    Key? key,
    this.width = double.infinity,
    this.background = Colors.purpleAccent,
    this.radius = 0.0,
    required this.onPressed,
    required this.text,
    this.isUpperCase = true,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: isUpperCase
            ? Text(
                text.toUpperCase(),
                style: style,
              )
            : Text(
                text,
                style: style,
              ),
      ),
    );
  }
}
