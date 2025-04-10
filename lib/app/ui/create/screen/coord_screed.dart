import 'package:flutter/material.dart';

class CoordScreed extends StatefulWidget {
  const CoordScreed({super.key});

  @override
  State<CoordScreed> createState() => _CoordScreedState();
}

class _CoordScreedState extends State<CoordScreed> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Center(child: Text("CoordScreed"))));
  }
}
