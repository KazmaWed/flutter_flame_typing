import 'package:freezed_annotation/freezed_annotation.dart';

import 'kayboard_layout.dart';

part 'game_setting.freezed.dart';

@freezed
abstract class GameSetting with _$GameSetting {
  const GameSetting._();
  const factory GameSetting({
    @Default(KeyboardLayout.qwerty) KeyboardLayout phisicalLayout,
    KeyboardLayout? logicalLayout,
    @Default(0) int gameMode,
    bool? se,
  }) = _GameSetting;

  bool get virtualMode => logicalLayout != null;
  String get keyboardSettingString =>
      '${virtualMode ? 'バーチャル${logicalLayout!.name}' : phisicalLayout.name}配列';
  String get seSettingString => 'サウンド${se! ? 'ON' : 'OFF'}';
}
