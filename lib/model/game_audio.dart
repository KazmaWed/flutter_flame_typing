import 'package:flame_audio/flame_audio.dart';

// オーディオアセットクラス
enum GameAudio {
  bgm('Neon_Drive.mp3', volume: 0.1),
  click('click.mp3', volume: 0.5),
  dying('dying.mp3', volume: 0.25),
  hit('hit.mp3'),
  reload('reload.mp3'),
  shoot('shoot.mp3'),
  wrong('wrong.mp3');

  // ファイル名
  final String path;
  final double volume;
  const GameAudio(this.path, {this.volume = 1.0});

  // BGMリスト
  static List<GameAudio> get bgms => [bgm];

  // サウンドエフェクトリスト
  static List<GameAudio> get soundEffects => [click, shoot, wrong, reload, hit, dying];
}

class GameAudioPlayer {
  GameAudioPlayer(this.enabled);
  final bool enabled;

  // 最大同時再生
  final _maxPlayers = 16;

  // オーディオプール
  final Map<GameAudio, AudioPool> _audioPools = {};

  //　ロード
  Future load() async {
    // オーディオファイルをロード
    await FlameAudio.audioCache.loadAll(GameAudio.values.map((e) => e.path).toList());
    // オーディオプールを作成
    for (var e in GameAudio.soundEffects) {
      FlameAudio.createPool(e.path, maxPlayers: _maxPlayers).then(
        (pool) => _audioPools[e] = pool,
      );
    }
    return;
  }

  // // オーディオファイルのキャッシュ用処理
  Future dryRun() async {
    for (var e in GameAudio.soundEffects) {
      await _audioPools[e]?.start(volume: 0.0001);
      await Future.delayed(const Duration(milliseconds: 50));
    }
    return;
  }

  void bgm() => FlameAudio.bgm.play(GameAudio.bgm.path, volume: GameAudio.bgm.volume);

  void play(GameAudio type, bool? enabled) {
    if (!(enabled ?? false)) return;
    if (type == GameAudio.bgm) {
      bgm();
    } else {
      _audioPools[type]?.start(volume: type.volume);
    }
  }

  void stopBgm() => FlameAudio.bgm.stop();
}
