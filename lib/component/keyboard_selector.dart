import 'package:flutter/material.dart';

import '../model/kayboard_layout.dart';
import 'square_button.dart';

class LayoutSelector extends StatelessWidget {
  const LayoutSelector({super.key, required this.onTap, required this.selected});
  final Function(KeyboardLayout) onTap;
  final KeyboardLayout selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var layout in KeyboardLayout.values)
          RectangleButton(
            onTap: () => onTap(layout),
            text: layout.name,
            filled: layout == selected,
          )
      ],
    );
  }
}
