import 'package:custom_paint/custom_paint/model/paint_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerPaint extends HookWidget {
  const DrawerPaint({
    super.key,
    required this.selectedColor,
    required this.brunchSize,
    required this.shape,
  });

  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<double> brunchSize;
  final ValueNotifier<PaintShapes> shape;

  Set<Color> get _palletColors => {
        Colors.white,
        Colors.black,
        Colors.yellow,
        Colors.green,
        Colors.blue,
        Colors.red,
        Colors.purple,
        Colors.pink,
        Colors.orange,
        Colors.brown,
        Colors.cyan,
        Colors.teal,
        Colors.lightGreen,
        Colors.lightBlue,
        Colors.amber,
        Colors.redAccent,
        Colors.purpleAccent,
        Colors.pinkAccent,
        Colors.deepOrangeAccent,
        Colors.lime,
      };

  @override
  Widget build(BuildContext context) {
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
          _shapes(),
          _colorTitle(),
          _colorOptions(),
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

  Widget _colorOptions() {
    return Wrap(
      runSpacing: 4,
      children: [
        ..._palletColors.map((color) => InkWell(
              onTap: () => selectedColor.value = color,
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

  Widget _shapes() {
    return Wrap(
      spacing: 12,
      children: [
        _shapeOption(FontAwesomeIcons.eraser, PaintShapes.erase),
        _shapeOption(FontAwesomeIcons.pencil, PaintShapes.line),
        _shapeOption(FontAwesomeIcons.square, PaintShapes.square),
        _shapeOption(FontAwesomeIcons.circle, PaintShapes.circle),
      ],
    );
  }

  Widget _shapeOption(IconData icon, PaintShapes shapeValue) {
    return GestureDetector(
      onTap: () => shape.value = shapeValue,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(
                color: shape.value == shapeValue
                    ? selectedColor.value
                    : Colors.black54)),
        child: FaIcon(
          icon,
          color:
              shape.value == shapeValue ? selectedColor.value : Colors.black54,
        ),
      ),
    );
  }
}
