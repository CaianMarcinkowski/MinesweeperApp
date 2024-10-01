import 'package:flutter/material.dart';
import 'package:minesweeper/components/field_widget.dart';
import 'package:minesweeper/models/field.dart';
import '../models/table.dart' as t;

class TableWidget extends StatelessWidget {
  final t.Table table;
  final void Function(Field) onOpen;
  final void Function(Field) onChange;

  TableWidget({
    required this.table,
    required this.onOpen,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: table.columns,
        children: table.fields.map((f) {
          return FieldWidget(
            field: f,
            onOpen: onOpen,
            onChange: onChange,
          );
        }).toList(),
      ),
    );
  }
}
