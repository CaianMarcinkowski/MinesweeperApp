import 'package:flutter/material.dart';
import 'package:minesweeper/components/table_widget.dart';
import 'package:minesweeper/models/explosion_exception.dart';
import 'package:minesweeper/models/field.dart';
import '../components/result_widget.dart';
import '../models/table.dart' as t;

class MinesweeperApp extends StatefulWidget {
  const MinesweeperApp({super.key});

  @override
  State<MinesweeperApp> createState() => _MinesweeperAppState();
}

class _MinesweeperAppState extends State<MinesweeperApp> {
  int _statusGame = 0;
  t.Table? _table;

  void _restart() {
    setState(() {
      _statusGame = 0;
      _table!.reset();
    });
  }

  void _open(Field f) {
    if (_statusGame != 0) return;
    setState(() {
      try {
        f.openBomb();
        if (_table!.resolved) {
          _statusGame = 1;
        }
      } on ExplosionException {
        _statusGame = 2;
        _table!.revealBombs();
      }
    });
  }

  void _close(Field f) {
    if (_statusGame != 0) return;
    setState(() {
      f.toggleSelection();
      if (_table!.resolved) {
        _statusGame = 1;
      }
    });
  }

  t.Table _getTable(double height, double width) {
    if (_table == null) {
      int qntColumn = 15;
      double sizeTable = width / qntColumn;
      int qtdRow = (height / sizeTable).floor();

      _table = t.Table(rows: qtdRow, columns: qntColumn, qtdBomb: 5);
    }
    return _table!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          statusGame: _statusGame,
          onRestart: _restart,
        ),
        body: LayoutBuilder(
          builder: (ctx, contraints) {
            return TableWidget(
              table: _getTable(
                contraints.maxHeight,
                contraints.maxWidth,
              ),
              onOpen: _open,
              onChange: _close,
            );
          },
        ),
      ),
    );
  }
}
