import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

class TextWithOverflowCheck extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;

  const TextWithOverflowCheck({
    super.key,
    required this.text,
    required this.size,
    this.weight = FontWeight.normal,
    this.color = Colors.black,
  });

  bool isTextOverflow(String text, TextStyle style, double maxWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.prompt(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isOverflow = isTextOverflow(text, style, constraints.maxWidth);
        log("isOverflow:$isOverflow");
        return isOverflow
            ? Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: size * 1.5,
                    child: Marquee(
                      text: text,
                      style: style,
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      blankSpace: 20.0,
                      velocity: 100.0,
                      pauseAfterRound: Duration(seconds: 1),
                      startPadding: 0.0,
                      accelerationDuration: Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: Duration(milliseconds: 500),
                      decelerationCurve: Curves.linear,
                    ),
                  ),
                ),
              ],
            )
            : Text(text, style: style);
      },
    );
  }
}
