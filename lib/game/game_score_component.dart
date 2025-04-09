import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../model/game_color.dart';
import '../model/game_score.dart';

class GameScoreComponent extends PositionComponent {
  GameScoreComponent({required this.score}) : super() {
    anchor = Anchor.center;
  }
  final GameScore score;

  // サイズを設定
  final padding = 18.0;
  final fontSize = 24.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final rowHeight = fontSize * 1.2;
    final valueColumnWidth = fontSize * 4;
    final titleColumnWidth = fontSize * 8;

    size = Vector2(
      titleColumnWidth + valueColumnWidth + padding * 2,
      rowHeight * 3 + padding * 2,
    ); // 必要に応じて調整

    // 背景のコンテナを追加
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = GameColor.black.halfTransparent,
    ));

    // テキストを追加
    final textPaint = TextPaint(
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'MadouFutoMaru',
        foreground: Paint()
          // ..style = PaintingStyle.stroke
          ..strokeWidth = 12
          ..color = GameColor.white,
      ),
    );
// テーブルデータ
    final tableData = [
      ['正解タイプ数', ': ${score.totalCorrectType}'],
      ['不正解タイプ数', ': ${score.totalIncorrectType}'],
      ['最大コンボ', ': ${score.maxCombo}'],
    ];

    // テキストコンポーネントをループで生成
    for (int i = 0; i < tableData.length; i++) {
      final row = tableData[i];
      for (int j = 0; j < row.length; j++) {
        add(TextComponent(
          anchor: Anchor.centerLeft,
          text: row[j],
          textRenderer: textPaint,
          position: Vector2(
            padding + titleColumnWidth * j,
            padding + (rowHeight * (i * 2 + 1)) / 2,
          ),
        ));
      }
    }
  }
}
