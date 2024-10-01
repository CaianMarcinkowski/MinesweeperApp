import 'package:flutter/material.dart';
import 'package:minesweeper/models/field.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onChange;

  FieldWidget({
    required this.field,
    required this.onOpen,
    required this.onChange,
  });

  Widget _getImage() {
    int qtdMines = field.countMineInNeighbor;
    return field.open && field.mined && field.exploded
        ? Image.asset('assets/images/bomba_0.jpeg')
        : field.open && field.mined
            ? Image.asset('assets/images/bomba_1.jpeg')
            : field.open
                ? Image.asset('assets/images/aberto_$qtdMines.jpeg')
                : field.selected
                    ? Image.asset('assets/images/bandeira.jpeg')
                    : Image.asset('assets/images/fechado.jpeg');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onChange(field),
      child: _getImage(),
    );
  }
}
