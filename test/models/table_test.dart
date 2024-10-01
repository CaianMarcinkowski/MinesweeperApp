import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/table.dart' as Table;

main() {
  test('Ganhar jogo', () {
    Table.Table t = Table.Table(
      rows: 2,
      columns: 2,
      qtdBomb: 0,
    );

    t.fields[0].mine();
    t.fields[3].mine();

    t.fields[0].toggleSelection();
    t.fields[1].openBomb();
    t.fields[2].openBomb();
    t.fields[3].toggleSelection();

    expect(t.resolved, isTrue);
  });
}
