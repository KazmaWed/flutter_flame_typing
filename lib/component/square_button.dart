import 'package:flutter/material.dart';

import '../model/game_color.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    super.key,
    required this.onTap,
    this.widget,
    this.text,
    this.border = false,
    this.filled = false,
    this.size = 160,
    this.textStyle,
    this.padding = const EdgeInsets.all(8.0),
  });
  final Function onTap;
  final Widget? widget;
  final String? text;
  final bool border;
  final bool filled;
  final double size;
  final TextStyle? textStyle;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final style =
        textStyle ?? Theme.of(context).textTheme.bodyLarge!.copyWith(color: GameColor.white);

    final backGround = filled ? GameColor.black.halfTransparent : GameColor.white;

    return Padding(
      padding: padding,
      child: Center(
        child: TextButton(
          onPressed: () => onTap(),
          style: TextButton.styleFrom(
            minimumSize: Size(size, size), // 幅200, 高さ60の長方形
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // 角を丸めず完全な長方形にする
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            backgroundColor: backGround, // 背景色
            foregroundColor: Colors.white, // 文字色
            textStyle: style,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget != null) widget!,
              if (text != null) Text(text ?? 'null'),
              if (widget == null && text == null) const Text('null'),
            ],
          ),
        ),
      ),
    );
  }
}

class RectangleButton extends StatelessWidget {
  const RectangleButton({
    super.key,
    required this.onTap,
    this.widget,
    this.text,
    this.border = false,
    this.filled = false,
    this.foregroundColor = GameColor.white,
    this.backgroundColor = GameColor.black,
    this.backgroundAlpha = 128,
    this.padding = const EdgeInsets.all(8),
  });
  final Function onTap;
  final Widget? widget;
  final String? text;
  final bool border;
  final bool filled;
  final Color foregroundColor;
  final Color backgroundColor;
  final int backgroundAlpha;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: filled ? backgroundColor : foregroundColor);

    final backGround = filled ? foregroundColor : backgroundColor.withAlpha(backgroundAlpha);

    return TextButton(
      onPressed: () => onTap(),
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // 角を丸めず完全な長方形にする
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        backgroundColor: backGround, // 背景色
        foregroundColor: style.color, // 文字色
        textStyle: style,
      ),
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget != null) widget!,
            if (text != null) Text(text ?? 'null'),
            if (widget == null && text == null) const Text('null'),
          ],
        ),
      ),
    );
  }
}
