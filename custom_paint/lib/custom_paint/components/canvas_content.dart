import 'package:custom_paint/custom_paint/model/paint_shapes.dart';
import 'package:custom_paint/custom_paint/model/sketch_model.dart';
import 'package:custom_paint/custom_paint/components/sketch_paint.dart';
import 'package:custom_paint/custom_paint/model/sketch_type_enum.dart';
import 'package:flutter/material.dart';

class CanvasContent extends StatelessWidget {
  const CanvasContent({
    super.key,
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildAllSketch(context),
        _buildCurrentSketch(context),
      ],
    );
  }

  Widget _buildAllSketch(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CustomPaint(
          painter: SketchPaint(
            sketchList: allSketch.value,
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentSketch(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        final offset = _getOffset(event, context);
        currentSketch.value = SketchModel(
          points: [offset],
          color: selectedColor.value,
          size: strokeSize.value,
          type: _getType(),
        );
      },
      onPointerMove: (event) {
        final offset = _getOffset(event, context);
        final points = <Offset>[...currentSketch.value?.points ?? [], offset];
        currentSketch.value = SketchModel(
          points: points,
          color: selectedColor.value,
          size: strokeSize.value,
          type: _getType(),
        );
      },
      onPointerUp: (_) {
        final sketch = currentSketch.value;
        if (sketch == null) {
          return;
        }
        allSketch.value = [...allSketch.value, sketch];
      },
      child: RepaintBoundary(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: SketchPaint(
              sketchList:
                  currentSketch.value != null ? [currentSketch.value!] : [],
            ),
          ),
        ),
      ),
    );
  }

  Offset _getOffset<T extends PointerEvent>(T event, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    return box.globalToLocal(event.position);
  }

  SketchType _getType() {
    switch (shape.value) {
      case PaintShapes.circle:
        return SketchType.circle;
      case PaintShapes.line:
        return SketchType.line;
      case PaintShapes.square:
        return SketchType.rectangle;
      case PaintShapes.free:
        return SketchType.free;
      case PaintShapes.erase:
        return SketchType.free;
    }
  }
}
