import 'package:flutter/material.dart';

import '../model/game_color.dart';
import 'square_button.dart';

class SquareSegmentedButton extends StatelessWidget {
  const SquareSegmentedButton({
    super.key,
    required this.labels,
    required this.currentIndex,
    required this.onSelect,
    required this.onHover,
  });
  final List<String> labels;
  final int currentIndex;
  final Function(int) onSelect;
  final Function(bool) onHover;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: GameColor.white,
      )),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: RectangleButton(
                onTap: () => onSelect(i),
                onHover: (value) => onHover(value),
                text: labels[i],
                filled: i == currentIndex,
              ),
            ),
        ],
      ),
    );
  }
}
