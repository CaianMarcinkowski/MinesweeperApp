import 'dart:math';

import 'field.dart';

class Table {
  final int rows;
  final int columns;
  final int qtdBomb;
  final List<Field> _fields = [];

  Table({
    required this.rows,
    required this.columns,
    required this.qtdBomb,
  }) {
    _criarCampos();
    _relateNeighbors();
  }

  void revealBombs() {
    _fields.forEach((f) => f.revealBomb());
  }

  void _criarCampos() {
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < columns; c++) {
        _fields.add(Field(row: r, column: c));
      }
    }
  }

  void _relateNeighbors() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  void reset() {
    _fields.forEach((f) => f.restart());
    _sortMine();
  }

  void _sortMine() {
    int sorts = 0;

    if (qtdBomb >= rows * columns) {
      return;
    }

    while (sorts < qtdBomb) {
      int i = Random().nextInt(_fields.length);

      if (!_fields[i].mined) {
        _fields[i].mine();
        sorts++;
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get resolved {
    return _fields.every((f) => f.resolved);
  }
}
