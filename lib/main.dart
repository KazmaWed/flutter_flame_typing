import 'package:firebase_core/firebase_core.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

import '../firebase_options.dart';
import '../model/game_audio.dart';
import '../model/game_color.dart';
import '../model/game_setting_manager.dart';
import '../screen/top_screen/top_screen.dart';
import '../theme.dart';
import 'model/app_info.dart';

final gameSize = Vector2(800, 450);
const menuWidth = 640.0;

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);

  // GetItの初期化
  GetIt.instance.registerSingleton(GameSettingManager());
  GetIt.instance.registerSingleton(GameAudioPlayer(false));
  GetIt.instance.registerSingleton(AppInfoManager);

  WidgetsFlutterBinding.ensureInitialized();

  // UUIDとアプリバージョンの取得
  PackageInfo.fromPlatform().then((info) {
    final appInfoManager = GetIt.I<AppInfoManager>();
    appInfoManager.update(
      AppInfo(
        uuid: const Uuid().v4(),
        appVersion: info.version,
      ),
    );
  });

  runApp(
    MaterialApp(
      title: 'Ninja Typer',
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
