import 'package:custom_paint/custom_paint/controller/paint_colors.dart';
import 'package:custom_paint/custom_paint/model/paint_shapes.dart';
import 'package:flutter/material.dart';

void fixColorWhenSetShape({
  required ValueNotifier<PaintShapes> currentShape,
  required PaintShapes shapeSelected,
  required ValueNotifier<Color> selectedColor,
  required Color lastChoosenColor,
}) {
  if (shapeSelected == PaintShapes.erase) {
    selectedColor.value = PaintColors.backgroundAndEraseColor;
    return;
  }
  selectedColor.value = lastChoosenColor;
  return;
}
