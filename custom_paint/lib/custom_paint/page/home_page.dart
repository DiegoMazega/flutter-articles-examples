import 'package:custom_paint/custom_paint/components/canvas_content.dart';
import 'package:custom_paint/custom_paint/controller/paint_colors.dart';
import 'package:custom_paint/custom_paint/controller/paint_use_controller.dart';
import 'package:custom_paint/custom_paint/components/drawer_paint.dart';
import 'package:custom_paint/custom_paint/store/paint_store.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(paintStoreProvider);
    final controller = paintUseController();

    return Scaffold(
      backgroundColor: PaintColors.backgroundAndEraseColor,
      drawer: DrawerPaint(
        selectedColor: controller.selectedColor,
        brunchSize: controller.strokeSize,
        shape: controller.shape,
      ),
      appBar: AppBar(
        title: Text('Paint'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: CanvasContent(
        selectedColor: controller.selectedColor,
        strokeSize: controller.strokeSize,
        eraseSize: controller.eraseSize,
        filled: controller.filled,
        polygonSides: controller.polygonSides,
        currentSketch: controller.currentSketch,
        allSketch: controller.allSketch,
        animationController: controller.animationController,
        shape: controller.shape,
      ),
    );
  }
}
