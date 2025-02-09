import 'package:custom_paint/custom_paint/model/sketch_model.dart';
import 'package:custom_paint/custom_paint/sketch_paint.dart';
import 'package:flutter/material.dart';

class CanvasPage extends StatelessWidget {
  const CanvasPage({
    super.key,
    required this.selectedColor,
    required this.strokeSize,
    required this.eraseSize,
    required this.filled,
    required this.polygonSides,
    required this.currentSketch,
    required this.allSketch,
    required this.animationController,
  });

  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<double> strokeSize;
  final ValueNotifier<double> eraseSize;
  final ValueNotifier<bool> filled;
  final ValueNotifier<int> polygonSides;
  final ValueNotifier<SketchModel?> currentSketch;
  final ValueNotifier<List<SketchModel>> allSketch;
  final AnimationController animationController;

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
        );
      },
      onPointerMove: (event) {
        final offset = _getOffset(event, context);
        final points = <Offset>[...currentSketch.value?.points ?? [], offset];
        currentSketch.value = SketchModel(
          points: points,
          color: selectedColor.value,
          size: strokeSize.value,
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
}
