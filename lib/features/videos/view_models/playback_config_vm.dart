import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/playback_config_repo.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoplay: value,
    );
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
      // sharepreferences の初期化が非同期で行われ、repository を使用できないため、ここでは暫定措置としてエラーを返す
      // main.dart > ProvideScope では PlaybackConfigViewModel で override して使用できるようにしている
      () => throw UnimplementedError(),
    );
