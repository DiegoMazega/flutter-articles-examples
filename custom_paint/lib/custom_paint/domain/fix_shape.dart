import 'package:custom_paint/custom_paint/model/paint_shapes.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

void fixShapeWhenSetColor({
  required PaintShapes lastChoosenShape,
  required ValueNotifier<PaintShapes> currentShape,
}) {
  if (currentShape.value != PaintShapes.erase) {
    return;
  }
  currentShape.value = lastChoosenShape;
}
