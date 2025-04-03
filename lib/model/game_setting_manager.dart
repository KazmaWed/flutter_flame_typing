import 'package:flutter_flame_typing/model/game_setting.dart';

import '../level/level_map.dart';
import 'kayboard_layout.dart';

class GameSettingManager {
  var _gameSetting = const GameSetting();
  GameSetting get gameSetting => _gameSetting;

  void update(GameSetting gameSetting) => _gameSetting = gameSetting;

  void toggleSe() {
    if (_gameSetting.se == null) return;
    _gameSetting = _gameSetting.copyWith(se: !_gameSetting.se!);
  }

  void setSe(bool to) => _gameSetting = _gameSetting.copyWith(se: to);

  void setPhisicalLayout(KeyboardLayout layout) =>
      _gameSetting = _gameSetting.copyWith(phisicalLayout: layout);

  void setLogicalLayout(KeyboardLayout? layout) =>
      _gameSetting = _gameSetting.copyWith(logicalLayout: layout);

  void setGameMode(GameMode mode) => _gameSetting = _gameSetting.copyWith(gameMode: mode.id);
}
