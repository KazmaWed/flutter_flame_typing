import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../component/square_button.dart';
import '../component/keyboard_layout_preview.dart';
import '../model/game_audio.dart';
import '../model/game_setting_manager.dart' show GameSettingManager;
import '../model/kayboard_layout.dart';

class KeyTestScreen extends StatefulWidget {
  const KeyTestScreen(this.layout, {super.key});
  final KeyboardLayout layout;

  @override
  State<KeyTestScreen> createState() => _KeyTestScreenState();
}

class _KeyTestScreenState extends State<KeyTestScreen> {
  final FocusNode _focusNode = FocusNode();
  String _string = '';

  void updateString(String input) {
    setState(() {
      _string += input;
      _string = _string.substring(max(_string.length - 10, 0), min(_string.length, 11));
    });
  }

  @override
  Widget build(BuildContext context) {
    final audio = GetIt.I.get<GameAudioPlayer>();
    final settingManager = GetIt.I.get<GameSettingManager>();
    final setting = settingManager.gameSetting;

    _focusNode.requestFocus();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('入力テスト'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RectangleButton(
              onTap: () => Navigator.of(context).pop(),
              onHover: (enter) => enter ? audio.play(GameAudio.click, setting.se) : null,
              widget: const Text('戻る'),
            )
          ],
        ),
      ),
      body: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: (KeyEvent event) {
          final char = event.character!;
          final swaped = KeyboardLayout.qwerty.keySwap(char, to: widget.layout);
          updateString(swaped);
          debugPrint(event.toString());
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'タイプしてください',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Text(
                _string == '' ? 'None' : _string,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20),
              KeyboardLayoutPreview(widget.layout),
            ],
          ),
        ),
      ),
    );
  }
}
