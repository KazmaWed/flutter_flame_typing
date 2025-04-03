import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../component/background_view.dart';
import '../../component/square_button.dart';
import '../../game_component/game_audio.dart';
import '../../model/game_setting.dart';
import '../../model/game_setting_manager.dart';
import '../keyboard_setting_screen.dart';
import 'top_screen_components.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  final audio = GetIt.instance.get<GameAudio>()..load();

  final settingManager = GetIt.instance.get<GameSettingManager>();
  GameSetting get setting => settingManager.gameSetting;

  final _pageController = PageController(initialPage: 0);

  void _animateToPage(int to) {
    _pageController.animateToPage(
      to,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _handlePageChanged(int page) {}

  final backgroundView = Center(
    child: ParallaxBackgroundView(
      gameSize: Vector2(800, 450),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      title: Container(
        alignment: Alignment.center,
        width: 720,
        child: const Row(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('タイプ・シューター'),
          ],
        ),
      ),
    );

    final bottomAppBar = GameBottomAppBar(
      onTapKeyboardSetting: () {
        if (setting.se ?? false) audio.shoot.start();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KeyboardSettingScreen(
              onSettingChanged: () => setState(() {}),
            ),
          ),
        );
      },
      onTapSe: () {
        setState(() {
          settingManager.toggleSe();
          if (setting.se ?? false) audio.shoot.start();
        });
      },
    );

    final views = [
      SoundModePickView(onTap: (se) {
        setState(() {
          settingManager.setSe(se);
          _animateToPage(1);
        });
        if (setting.se ?? false) audio.shoot.start();
      }),
      LevelPickView(
        se: setting.se ?? false,
        bgm: setting.se ?? false,
      )
    ];

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomAppBar,
      body: Stack(
        children: [
          backgroundView,
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  height: 480,
                  child: PageView.builder(
                    itemBuilder: (context, index) => views[index],
                    controller: _pageController,
                    onPageChanged: _handlePageChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
