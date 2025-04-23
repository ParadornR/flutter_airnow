import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;
  final int maxLines;
  const CustomText({
    super.key,
    required this.text,
    required this.size,
    this.weight = FontWeight.normal,
    this.color = Colors.black,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: GoogleFonts.prompt(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }
}
