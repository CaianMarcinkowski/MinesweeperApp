import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/models/field.dart';

main() {
  group('Campo', () {
    test('Abrir campo com explosão', () {
      Field f = Field(row: 0, column: 0);
      f.mine();

      expect(f.openBomb, throwsException);
    });
    test('Abrir campo sem explosão', () {
      Field f = Field(row: 0, column: 0);
      f.openBomb();

      expect(f.open, isTrue);
    });
    test('Add não vizinho', () {
      Field f1 = Field(row: 0, column: 0);
      Field f2 = Field(row: 1, column: 3);

      f1.addNeighbor(f2);
      expect(f1.neighbors.isEmpty, isTrue);
    });
    test('Adicionar vizinho', () {
      Field f1 = Field(row: 3, column: 3);
      Field f2 = Field(row: 3, column: 4);
      Field f3 = Field(row: 2, column: 2);
      Field f4 = Field(row: 4, column: 4);

      f1.addNeighbor(f2);
      f1.addNeighbor(f3);
      f1.addNeighbor(f4);

      expect(f1.neighbors.length, 3);
    });

    test('Minas na vizinhança!', () {
      Field f1 = Field(row: 3, column: 3);

      Field f2 = Field(row: 3, column: 4);
      f2.mine();

      Field f3 = Field(row: 2, column: 2);

      Field f4 = Field(row: 4, column: 4);
      f4.mine();

      f1.addNeighbor(f2);
      f1.addNeighbor(f3);
      f1.addNeighbor(f4);

      expect(f1.countMineInNeighbor, 2);
    });
  });
}
