import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final int statusGame;
  final VoidCallback onRestart;

  // Definir valores padrão
  ResultWidget({
    required this.statusGame,
    required this.onRestart,
  });

  // 0 - Neutral;
  // 1 - Winning;
  // 2 or other - Loose;
  Color _getColor() {
    return statusGame == 0
        ? Colors.yellow
        : statusGame == 1
            ? Colors.green
            : Colors.red;
  }

  IconData _getIcon() {
    return statusGame == 0
        ? Icons.sentiment_satisfied
        : statusGame == 1
            ? Icons.sentiment_very_satisfied
            : Icons.sentiment_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
          child: Container(
        padding: EdgeInsets.all(10),
        child: CircleAvatar(
          backgroundColor: _getColor(),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            icon: Icon(
              _getIcon(),
              color: Colors.black,
              size: 35,
            ),
            onPressed: onRestart,
          ),
        ),
      )),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(120);
}
