import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';

class CustomField extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextEditingController controller;
  const CustomField({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA3E4FA), Color(0xFFD1F8EF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.person),
              SizedBox(width: 16),
              CustomText(text: title, size: 16),
            ],
          ),
        ),
        SizedBox(height: 2),
        Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA3E4FA), Color(0xFFD1F8EF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
