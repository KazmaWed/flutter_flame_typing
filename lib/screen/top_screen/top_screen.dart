import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../component/background_view.dart';
import '../../model/game_audio.dart';
import '../../model/game_setting.dart';
import '../../model/game_setting_manager.dart';
import '../../screen/top_screen/top_screen_components.dart';
import '../keyboard_setting_screen.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  final audio = GetIt.instance.get<GameAudioPlayer>();
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

  final _backgroundView = Center(
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
        audio.play(GameAudio.shoot, setting.se);
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
          audio.play(GameAudio.shoot, setting.se);
        });
      },
    );

    final views = [
      SoundModePickView(
        onTap: (se) async {
          setState(() => settingManager.setSe(se));
          await audio.dryRun();
          audio.play(GameAudio.shoot, setting.se);
          _animateToPage(1);
        },
      ),
      const LevelPickView()
    ];

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomAppBar,
      body: Stack(
        children: [
          _backgroundView,
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
