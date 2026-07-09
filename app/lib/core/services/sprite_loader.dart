import '../../models/companion_state.dart';

class SpriteLoader {
  static const String _basePath = 'assets/sprites';

  static List<String> framesForState(CompanionState state) {
    final folder = switch (state) {
      CompanionState.idle => 'idle',
      CompanionState.walk => 'walk',
      CompanionState.talk => 'idle',
      CompanionState.drink => 'drink',
      CompanionState.happy => 'happy',
      CompanionState.sleep => 'sleep',
      CompanionState.celebrate => 'celebrate',
    };

    return [
      '$_basePath/$folder/0.png',
      '$_basePath/$folder/1.png',
      '$_basePath/$folder/2.png',
    ];
  }

  static String defaultSpritePath() => '$_basePath/idle/0.png';
}
