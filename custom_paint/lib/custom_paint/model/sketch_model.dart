import 'package:custom_paint/custom_paint/model/sketch_type_enum.dart';
import 'package:flutter/material.dart';

class SketchModel {
  SketchModel({
    required this.points,
    this.color = Colors.black,
    this.size = 10,
    this.type = SketchType.free,
  });

  final List<Offset> points;
  final Color color;
  final double size;
  final SketchType type;
}
