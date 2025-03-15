import 'package:custom_paint/custom_paint/model/paint_shapes.dart';
import 'package:custom_paint/custom_paint/model/paint_store_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaintStore extends Notifier<PaintStoreModel> {
  @override
  PaintStoreModel build() {
    return PaintStoreModel(
      lastChoosenColor: Colors.black,
      lastChoosenShape: PaintShapes.line,
    );
  }

  Color get lastChoosenColor => state.lastChoosenColor;

  PaintShapes get lastChoosenShape => state.lastChoosenShape;

  void updateLastSelectedColor(Color newColor) {
    final currentState = state;
    final updateState = currentState.copyWith(
      lastChoosenColor: newColor,
    );
    state = updateState;
  }

  void updateLastSelectedShape(PaintShapes newShape) {
    if (newShape == PaintShapes.erase || newShape == state.lastChoosenShape) {
      return;
    }
    final currentState = state;
    final updateState = currentState.copyWith(
      lastChoosenShape: newShape,
    );
    state = updateState;
  }
}

final paintStoreProvider = NotifierProvider<PaintStore, PaintStoreModel>(
  () => PaintStore(),
);
