import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../component/keyboard_layout_preview.dart';
import '../component/keyboard_selector.dart';
import '../component/section_container.dart';
import '../component/square_button.dart';
import '../model/game_audio.dart';
import '../model/game_color.dart';
import '../model/game_setting.dart';
import '../model/game_setting_manager.dart';
import '../model/kayboard_layout.dart';
import '../screen/key_test_screen.dart';

class KeyboardSettingScreen extends StatefulWidget {
  const KeyboardSettingScreen({
    super.key,
    required this.onSettingChanged,
  });

  final Function onSettingChanged;

  @override
  State<KeyboardSettingScreen> createState() => _KeyboardSettingScreenState();
}

class _KeyboardSettingScreenState extends State<KeyboardSettingScreen> {
  final audio = GetIt.instance.get<GameAudioPlayer>();
  final settingManager = GetIt.instance.get<GameSettingManager>();
  GameSetting get setting => settingManager.gameSetting;

  KeyboardLayout get phisicalLayout => setting.phisicalLayout;
  KeyboardLayout? get logicalLayout => setting.logicalLayout;
  bool get virtualMode => setting.virtualMode;

  @override
  Widget build(BuildContext context) {
    const aboutVirtualMode = 'バーチャルモードをONにすると、実際に使っているキーボードの配列は違う配列をシュミレーションしてゲームを遊ぶことができます。\n\n'
        '例えばQwerty配列 (一番よくあるキーボード) を使っているけど、Colemakでゲームをプレイしたければ、バーチャルモードをONにして、上のスイッチでQwerty、下のスイッチでColemakを選択してください。';

    return Scaffold(
      appBar: AppBar(
        title: const Text('キーボード設定'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 18,
          children: [
            RectangleButton(
              padding: EdgeInsets.zero,
              onTap: () {
                audio.play(GameAudio.shoot, setting.se);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        KeyTestScreen(virtualMode ? logicalLayout! : phisicalLayout),
                  ),
                );
              },
              onHover: (enter) => enter ? audio.play(GameAudio.click, setting.se) : null,
              text: '入力テスト',
            ),
            RectangleButton(
              padding: EdgeInsets.zero,
              onTap: () {
                audio.play(GameAudio.shoot, setting.se);
                Navigator.of(context).pop();
              },
              onHover: (enter) => enter ? audio.play(GameAudio.click, setting.se) : null,
              text: '決定',
            ),
          ],
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 720,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 物理キーボードの設定
              SectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('使用キーボード'),
                        ),
                        const Spacer(),
                        LayoutSelector(
                          onTap: (layout) {
                            // 論理キーボードと同じ場合はリセット
                            if (setting.logicalLayout == layout) {
                              settingManager.setLogicalLayout(null);
                            }

                            audio.play(GameAudio.reload, setting.se);
                            setState(() {
                              settingManager.setPhisicalLayout(layout);
                              // phisicalLayout = layout;
                            });
                            widget.onSettingChanged();
                          },
                          onHover: (enter) =>
                              enter ? audio.play(GameAudio.click, setting.se) : null,
                          selected: phisicalLayout,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KeyboardLayoutPreview(phisicalLayout),
                      ],
                    ),
                  ],
                ),
              ),
              // バーチャルキーボードの設定
              SectionContainer(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('バーチャルキーボード'),
                          const Spacer(),
                          RectangleButton(
                            onTap: () {
                              audio.play(GameAudio.reload, setting.se);
                              setState(() => settingManager.setLogicalLayout(null));
                              widget.onSettingChanged();
                            },
                            onHover: (enter) =>
                                enter ? audio.play(GameAudio.click, setting.se) : null,
                            text: 'OFF',
                            filled: !virtualMode,
                          ),
                          for (var layout in KeyboardLayout.values)
                            RectangleButton(
                              onTap: () {
                                // 物理キーボードと同じ場合は押せない
                                if (setting.phisicalLayout == layout) {
                                  audio.play(GameAudio.wrong, setting.se);
                                  return;
                                }

                                audio.play(GameAudio.reload, setting.se);
                                setState(() {
                                  settingManager.setLogicalLayout(layout);
                                });
                                widget.onSettingChanged();
                              },
                              onHover: (enter) =>
                                  enter ? audio.play(GameAudio.click, setting.se) : null,
                              text: layout.name,
                              filled: virtualMode && layout == logicalLayout,
                              foregroundColor: setting.phisicalLayout == layout
                                  ? GameColor.white.withAlpha(64)
                                  : Colors.white,
                            ),
                        ],
                      ),
                    ),
                    IndexedStack(
                      index: virtualMode ? 0 : 1,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                KeyboardLayoutPreview(logicalLayout),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(12),
                              alignment: Alignment.center,
                              color: GameColor.pageBackground,
                              child: Text(aboutVirtualMode,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: GameColor.white.halfTransparent)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
