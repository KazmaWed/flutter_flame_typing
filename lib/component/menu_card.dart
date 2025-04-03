import 'package:flutter/material.dart';

import '../model/game_color.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.onTap,
    this.trailing,
    this.title,
    this.text,
    this.titleStyle,
    this.textStyle,
    this.color = GameColor.white,
  });
  final Function onTap;
  final Widget? trailing;
  final String? title;
  final String? text;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      color: color.withAlpha(25),
      child: Ink(
        child: InkWell(
          hoverColor: GameColor.highlightTransparent,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                if (trailing != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: trailing ?? Container(),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: titleStyle ?? Theme.of(context).textTheme.titleMedium!,
                      ),
                    if (text != null)
                      Text(
                        text!,
                        style: textStyle ?? Theme.of(context).textTheme.bodyMedium!,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
