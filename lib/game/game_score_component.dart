import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../model/game_color.dart';
import '../model/game_score.dart';
import '../model/game_score_class.dart';

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
    final scoreClass = GameScoreClass.fromScore(score.lpm.floor());

    // テーブルデータ
    const title = 'リザルト';
    final tableData = [
      ['クリアタイム', ': ${score.time.toStringAsFixed(2)} 秒'],
      ['正解タイプ数', ': ${score.totalCorrectType} 文字'],
      ['不正解タイプ数', ': ${score.totalIncorrectType} 文字'],
      ['最大コンボ', ': ${score.maxCombo} コンボ'],
      [],
      ['正解率', ': ${score.accuracy.toStringAsFixed(1)} %'],
      ['タイピング速度', ': ${score.lpm.toStringAsFixed(1)} 文字/分'],
      [],
      ['レベル', ': ${scoreClass.level}. ${scoreClass.title}'],
    ];

    final titleHeight = fontSize * 1.5;
    final rowHeight = fontSize * 1.2;
    final keyColumnWidth = fontSize * 8;
    final valueColumnWidth = fontSize * 10;
    size = Vector2(
      keyColumnWidth + valueColumnWidth + padding * 2,
      titleHeight + rowHeight * tableData.length + padding * 3,
    ); // 必要に応じて調整

    // 背景のコンテナを追加
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = GameColor.black.halfTransparent,
    ));

    // テキストを追加
    final titlePaint = TextPaint(
      style: TextStyle(
        fontSize: fontSize * 1.2,
        fontFamily: 'MadouFutoMaru',
        foreground: Paint()..color = GameColor.black,
      ),
    );
    final titleOutlinePaint = TextPaint(
      style: TextStyle(
        fontSize: fontSize * 1.2,
        fontFamily: 'MadouFutoMaru',
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..color = GameColor.white,
      ),
    );
    final textPaint = TextPaint(
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'MadouFutoMaru',
        foreground: Paint()..color = GameColor.white,
      ),
    );

    addAll(
      [
        TextComponent(
          anchor: Anchor.topCenter,
          text: title,
          textRenderer: titleOutlinePaint,
          position: Vector2(size.x / 2, padding * 1.2),
        ),
        TextComponent(
          anchor: Anchor.topCenter,
          text: title,
          textRenderer: titlePaint,
          position: Vector2(size.x / 2, padding * 1.2),
        ),
      ],
    );
    // テキストコンポーネントをループで生成
    for (int i = 0; i < tableData.length; i++) {
      final row = tableData[i];
      for (int j = 0; j < row.length; j++) {
        add(TextComponent(
          anchor: Anchor.centerLeft,
          text: row[j],
          textRenderer: textPaint,
          position: Vector2(
            padding + keyColumnWidth * j,
            titleHeight + padding * 2 + (rowHeight * (i * 2 + 1)) / 2,
          ),
        ));
      }
    }
  }
}
