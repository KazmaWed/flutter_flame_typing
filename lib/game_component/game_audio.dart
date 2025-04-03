import 'package:flame_audio/flame_audio.dart';

class GameAudio {
  GameAudio(this.enabled);
  final bool enabled;

  // 最大同時再生
  final _max = 8;
  // ファイル名
  final _shoot = 'shoot.mp3';
  final _wrong = 'wrong.mp3';
  final _reload = 'reload.mp3';
  final _hit = 'hit.mp3';
  final _dying = 'dying.mp3';
  final _bgm = 'Neon_Drive.mp3';
  late final _files = [_shoot, _wrong, _reload, _hit, _dying, _bgm];

  // オーディオプール
  late final AudioPool shoot;
  late final AudioPool wrong;
  late final AudioPool reload;
  late final AudioPool hit;
  late final AudioPool dying;

  //　ロード
  Future load() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll(_files);
    shoot = await FlameAudio.createPool(_shoot, maxPlayers: _max);
    wrong = await FlameAudio.createPool(_wrong, maxPlayers: _max);
    reload = await FlameAudio.createPool(_reload, maxPlayers: _max);
    hit = await FlameAudio.createPool(_hit, maxPlayers: _max);
    dying = await FlameAudio.createPool(_dying, maxPlayers: _max);
  }

  void bgm() => FlameAudio.bgm.play(_bgm, volume: 0.2);
  void stopBgm() => FlameAudio.bgm.stop();
}
