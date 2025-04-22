import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;
  const CustomText({
    super.key,
    required this.text,
    required this.size,
    this.weight = FontWeight.normal,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.prompt(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }
}
