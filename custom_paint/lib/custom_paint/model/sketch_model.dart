import 'package:flutter/material.dart';

class SketchModel {
  SketchModel({
    required this.points,
    this.color = Colors.black,
    this.size = 10,
  });

  final List<Offset> points;
  final Color color;
  final double size;
}
