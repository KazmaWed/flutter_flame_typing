import 'package:flutter/material.dart';

import '../model/game_color.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: GameColor.pageBackground,
        );
    return Container(
      color: GameColor.white,
      width: double.maxFinite,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      child: Text(title, style: titleStyle),
    );
  }
}

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.color,
    this.padding = const EdgeInsets.all(16),
  });
  final Widget child;
  final Color? color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: GameColor.white,
        ),
      ),
      child: child,
    );
  }
}
