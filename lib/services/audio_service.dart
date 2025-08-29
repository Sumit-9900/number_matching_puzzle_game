import 'package:audioplayers/audioplayers.dart';
import 'package:number_matching_puzzle_game/core/constants/app_constants.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  void playButtonClick() async {
    await _player.play(AssetSource(AppConstants.buttonClickSound), volume: 1.0);
  }

  void playQuickWinSound() async {
    await _player.play(AssetSource(AppConstants.quickWinSound), volume: 1.0);
  }

  void playErrorSound() async {
    await _player.play(AssetSource(AppConstants.errorSound), volume: 0.8);
  }

  void playSuccessSound() async {
    await _player.play(AssetSource(AppConstants.successSound), volume: 0.2);
  }

  void playClockTickingSound() async {
    await _player.play(
      AssetSource(AppConstants.clockTickingSound),
      volume: 1.0,
    );
  }

  void dispose() {
    _player.dispose();
  }
}
