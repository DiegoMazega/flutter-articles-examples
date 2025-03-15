import 'package:flutter/material.dart';

import 'package:custom_paint/custom_paint/model/paint_shapes.dart';

class PaintStoreModel {
  PaintStoreModel({
    required this.lastChoosenColor,
    required this.lastChoosenShape,
  });

  final Color lastChoosenColor;
  final PaintShapes lastChoosenShape;

  PaintStoreModel copyWith({
    Color? lastChoosenColor,
    PaintShapes? lastChoosenShape,
  }) {
    return PaintStoreModel(
      lastChoosenColor: lastChoosenColor ?? this.lastChoosenColor,
      lastChoosenShape: lastChoosenShape ?? this.lastChoosenShape,
    );
  }
}
