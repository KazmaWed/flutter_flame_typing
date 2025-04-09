import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../component/section_container.dart';
import '../../component/square_button.dart';
import '../../component/square_segmented_button.dart';
import '../../level/level_map.dart';
import '../../level/position_practice_level.dart';
import '../../level/word_typing_level.dart';
import '../../main.dart';
import '../../model/game_audio.dart';
import '../../model/game_color.dart';
import '../../model/game_setting.dart';
import '../../model/game_setting_manager.dart';
import '../../model/level.dart';
import '../../model/word.dart';
import '../../theme.dart';
import '../typing_game_screen.dart';

class GameBottomAppBar extends StatelessWidget {
  const GameBottomAppBar({
    super.key,
    required this.onTapKeyboardSetting,
    required this.onTapSe,
  });
  final Function onTapKeyboardSetting;
  final Function onTapSe;

  @override
  Widget build(BuildContext context) {
    final settingManager = GetIt.I.get<GameSettingManager>();
    GameSetting setting = settingManager.gameSetting;

    return BottomAppBar(
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RectangleButton(
            onTap: () => onTapKeyboardSetting(),
            widget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                spacing: 8.0,
                children: [
                  const Icon(Icons.keyboard_alt_sharp),
                  Text(setting.keyboardSettingString),
                ],
              ),
            ),
          ),
          if (setting.se != null)
            RectangleButton(
              onTap: () => onTapSe(),
              widget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  spacing: 8.0,
                  children: [
                    Icon(setting.se! ? Icons.volume_up_sharp : Icons.volume_off_sharp),
                    Text(setting.seSettingString),
                  ],
                ),
              ),
            ),
          const Spacer(),
          RectangleButton(
            onTap: () {},
            widget: const Text('Github'),
          ),
        ],
      ),
    );
  }
}

class SoundModePickView extends StatelessWidget {
  const SoundModePickView({
    super.key,
    required this.onTap,
  });
  final Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    const items = {
      'サウンドON': true,
      'サウンドOFF': false,
    };

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Text('設定', style: Theme.of(context).textTheme.outlineLarge),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.entries
                .map(
                  (e) => SquareButton(
                    onTap: () => onTap(e.value),
                    widget: Text(e.key),
                    filled: true,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class LevelPickView extends StatefulWidget {
  const LevelPickView({super.key});

  @override
  State<LevelPickView> createState() => _LevelPickViewState();
}

class _LevelPickViewState extends State<LevelPickView> {
  final audio = GetIt.instance.get<GameAudioPlayer>();
  final settingManager = GetIt.I.get<GameSettingManager>();
  GameSetting get setting => settingManager.gameSetting;

  late final Map<String, List<List<Level Function()>>> levelsMap = {
    WordPracticeMode().title: [
      WordPracticeLevel.generators(Language.japanese),
      WordPracticeLevel.generators(Language.english),
      WordPracticeLevel.generators(Language.program),
    ],
    PositionPracticeMode().title: [
      PositionPracticeLevel.rows(),
      PositionPracticeLevel.sides(),
    ]
  };

  @override
  Widget build(BuildContext context) {
    Widget levelSelect() {
      return IndexedStack(
        index: setting.gameMode,
        children: [
          for (var key in levelsMap.keys)
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      for (var levels in levelsMap[key]!)
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            for (var level in levels)
                              RectangleButton(
                                backgroundAlpha: 0,
                                onTap: () {
                                  audio.play(GameAudio.shoot, setting.se);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TypingGameScreen(
                                        level: level(),
                                        phisicalLayout: setting.phisicalLayout,
                                        virtualLayout:
                                            setting.virtualMode ? setting.logicalLayout : null,
                                        se: setting.se ?? false,
                                        bgm: setting.se ?? false,
                                      ),
                                    ),
                                  );
                                },
                                text: level().title,
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      );
    }

    return Center(
      child: SizedBox(
        width: menuWidth,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            Text(
              'モード選択',
              style: Theme.of(context).textTheme.outlineLarge,
            ),
            SquareSegmentedButton(
                labels: levelsMap.keys.toList(),
                currentIndex: setting.gameMode,
                onSelect: (i) {
                  audio.play(GameAudio.shoot, setting.se);
                  setState(() {
                    settingManager.setGameMode(GameMode.fromId(i));
                  });
                }),
            const SizedBox(height: 12),
            Text(
              'レベル選択',
              style: Theme.of(context).textTheme.outlineLarge,
            ),
            SectionContainer(
              color: GameColor.black.halfTransparent,
              child: levelSelect(),
            ),
          ],
        ),
      ),
    );
  }
}
