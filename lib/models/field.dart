import 'explosion_exception.dart';

class Field {
  final int row;
  final int column;
  final List<Field> neighbors = [];

  bool _open = false;
  bool _selected = false;
  bool _mined = false;
  bool _exploded = false;

  Field({
    required this.row,
    required this.column,
  });

  void addNeighbor(Field neighbor) {
    final deltRow = (row - neighbor.row).abs();
    final deltColumn = (column - neighbor.column).abs();

    if (deltRow == 0 && deltColumn == 0) {
      return;
    }

    if (deltRow <= 1 && deltColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void openBomb() {
    // Se o campo já está aberto, não faz nada
    if (_open) {
      return;
    }

    _open = true; // Marca o campo como aberto

    // Se o campo está minado, marca como explodido e lança uma exceção
    if (_mined) {
      _exploded = true;
      throw ExplosionException();
    }

    // Se o campo não está minado e tem vizinhos seguros, abre os vizinhos
    if (safeNeighbor) {
      // Itera sobre os vizinhos e chama openBomb() neles
      for (var neighbor in neighbors) {
        neighbor.openBomb(); // Abre cada vizinho recursivamente
      }
    }
  }

  void revealBomb() {
    if (_mined) {
      _open = true;
    }
  }

  void mine() {
    _mined = true;
  }

  void toggleSelection() {
    _selected = !_selected;
  }

  void restart() {
    _exploded = false;
    _mined = false;
    _open = false;
    _selected = false;
  }

  bool get mined {
    return _mined;
  }

  bool get exploded {
    return _exploded;
  }

  bool get open {
    return _open;
  }

  bool get selected {
    return _selected;
  }

  bool get resolved {
    bool minedAndSelected = mined && selected;
    bool safeAndOpened = !mined && open;
    return minedAndSelected || safeAndOpened;
  }

  int get countMineInNeighbor {
    return neighbors.where((v) => v.mined).length;
  }

  bool get safeNeighbor {
    return neighbors.every((v) => !v._mined);
  }
}
