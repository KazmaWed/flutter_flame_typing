import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_flame_typing/component/square_button.dart';

import '../component/keyboard_layout_preview.dart';
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
