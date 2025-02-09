import 'package:custom_paint/custom_paint/model/paint_shapes.dart';
import 'package:custom_paint/custom_paint/model/sketch_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PaintUseController {
  const PaintUseController({
    required this.selectedColor,
    required this.strokeSize,
    required this.eraseSize,
    required this.filled,
    required this.polygonSides,
    required this.currentSketch,
    required this.allSketch,
    required this.animationController,
    required this.shape,
  });

  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<double> strokeSize;
  final ValueNotifier<double> eraseSize;
  final ValueNotifier<bool> filled;
  final ValueNotifier<int> polygonSides;
  final ValueNotifier<SketchModel?> currentSketch;
  final ValueNotifier<List<SketchModel>> allSketch;
  final AnimationController animationController;
  final ValueNotifier<PaintShapes> shape;
}

PaintUseController paintUseController() {
  final selectedColor = useState<Color>(Colors.black);
  final strokeSize = useState<double>(10);
  final eraseSize = useState<double>(30);
  final filled = useState(false);
  final polygonSides = useState<int>(3);
  final currentSketch = useState<SketchModel?>(null);
  final allSketch = useState<List<SketchModel>>([]);
  final shape = useState<PaintShapes>(PaintShapes.line);
  final animationController = useAnimationController(
    duration: const Duration(milliseconds: 250),
    initialValue: 1,
  );

  return PaintUseController(
    shape: shape,
    polygonSides: polygonSides,
    currentSketch: currentSketch,
    animationController: animationController,
    allSketch: allSketch,
    selectedColor: selectedColor,
    strokeSize: strokeSize,
    eraseSize: eraseSize,
    filled: filled,
  );
}
