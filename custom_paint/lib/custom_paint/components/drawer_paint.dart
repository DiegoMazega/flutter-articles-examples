import 'package:custom_paint/custom_paint/controller/paint_colors.dart';
import 'package:custom_paint/custom_paint/domain/fix_color.dart';
import 'package:custom_paint/custom_paint/domain/fix_shape.dart';
import 'package:custom_paint/custom_paint/model/paint_shapes.dart';
import 'package:custom_paint/custom_paint/store/paint_store.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrawerPaint extends HookConsumerWidget {
  const DrawerPaint({
    super.key,
    required this.selectedColor,
    required this.brunchSize,
    required this.shape,
  });

  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<double> brunchSize;
  final ValueNotifier<PaintShapes> shape;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tile(),
          const Divider(
            color: Colors.black,
            thickness: 1.5,
          ),
          _shapes(ref),
          _colorTitle(),
          _colorOptions(ref),
          _sizeTitle(),
          _brunchSize()
        ],
      ),
    );
  }

  Widget _tile() {
    return Center(
      child: Text(
        'Configurações',
        textAlign: TextAlign.center,
        style: TextStyle(
          height: 1.2,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _colorTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 4,
      children: [
        Text(
          'Cores',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.2,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.black45,
              width: 0.5,
            ),
            color: selectedColor.value,
          ),
        ),
      ],
    );
  }

  Widget _colorOptions(WidgetRef ref) {
    return Wrap(
      runSpacing: 4,
      children: [
        ...PaintColors.palletColors.map((color) => InkWell(
              onTap: () {
                ref
                    .read(paintStoreProvider.notifier)
                    .updateLastSelectedColor(color);

                fixShapeWhenSetColor(
                  lastChoosenShape:
                      ref.read(paintStoreProvider).lastChoosenShape,
                  currentShape: shape,
                );

                selectedColor.value = color;
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.black45,
                    width: 0.5,
                  ),
                  color: color,
                ),
              ),
            ))
      ],
    );
  }

  Widget _sizeTitle() {
    return Text(
      'Pincel',
      textAlign: TextAlign.center,
      style: TextStyle(
        height: 1.2,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    );
  }

  Widget _brunchSize() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 6,
      children: [
        Text(
          'Tamanho:',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.2,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        Expanded(
          child: Slider(
            activeColor: selectedColor.value,
            value: brunchSize.value,
            max: 100,
            min: 1,
            onChanged: (double value) => brunchSize.value = value,
          ),
        ),
      ],
    );
  }

  Widget _shapes(WidgetRef ref) {
    return Wrap(
      spacing: 12,
      children: [
        _shapeOption(
          FontAwesomeIcons.eraser,
          PaintShapes.erase,
          ref,
        ),
        _shapeOption(
          FontAwesomeIcons.pencil,
          PaintShapes.free,
          ref,
        ),
        _shapeOption(
          FontAwesomeIcons.minus,
          PaintShapes.line,
          ref,
        ),
        _shapeOption(
          FontAwesomeIcons.square,
          PaintShapes.square,
          ref,
        ),
        _shapeOption(
          FontAwesomeIcons.circle,
          PaintShapes.circle,
          ref,
        ),
      ],
    );
  }

  Widget _shapeOption(
    IconData icon,
    PaintShapes shapeValue,
    WidgetRef ref,
  ) {
    return GestureDetector(
      onTap: () {
        ref
            .read(paintStoreProvider.notifier)
            .updateLastSelectedShape(shapeValue);

        fixColorWhenSetShape(
          shapeSelected: shapeValue,
          currentShape: shape,
          selectedColor: selectedColor,
          lastChoosenColor: ref.read(paintStoreProvider).lastChoosenColor,
        );

        shape.value = shapeValue;
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(
                color: shape.value == shapeValue
                    ? PaintColors.selectIconColor
                    : PaintColors.notSelectIconColor)),
        child: FaIcon(
          icon,
          color: shape.value == shapeValue
              ? PaintColors.selectIconColor
              : PaintColors.notSelectIconColor,
        ),
      ),
    );
  }
}
