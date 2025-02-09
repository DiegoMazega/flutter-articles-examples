import 'package:custom_paint/custom_paint/canvas_page.dart';
import 'package:custom_paint/custom_paint/controller/paint_use_controller.dart';
import 'package:custom_paint/custom_paint/drawer_paint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = paintUseController();

    return Scaffold(
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
      body: CanvasPage(
        selectedColor: controller.selectedColor,
        strokeSize: controller.strokeSize,
        eraseSize: controller.eraseSize,
        filled: controller.filled,
        polygonSides: controller.polygonSides,
        currentSketch: controller.currentSketch,
        allSketch: controller.allSketch,
        animationController: controller.animationController,
      ),
    );
  }
}
