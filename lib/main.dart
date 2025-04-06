import 'package:firebase_core/firebase_core.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../firebase_options.dart';
import '../model/game_audio.dart';
import '../model/game_color.dart';
import '../model/game_setting_manager.dart';
import '../screen/top_screen/top_screen.dart';
import '../theme.dart';

final gameSize = Vector2(800, 450);
const menuWidth = 640.0;

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);

  // GetItの初期化
  GetIt.instance.registerSingleton(GameSettingManager());
  GetIt.instance.registerSingleton(GameAudioPlayer(false));

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'TypingGame',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(primary: GameColor.white),
        scaffoldBackgroundColor: GameColor.pageBackground,
        fontFamily: 'MadouFutoMaru',
        textTheme: textTheme,
      ),
      home: const TopScreen(),
    ),
  );
}
