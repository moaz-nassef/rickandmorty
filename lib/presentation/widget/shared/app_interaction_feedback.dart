import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class AppInteractionFeedback {
  AppInteractionFeedback._();

  static final AudioPlayer _player = AudioPlayer();

  static void tap() {
    HapticFeedback.selectionClick();
    unawaited(_playClick());
  }

  static void success() {
    HapticFeedback.lightImpact();
    unawaited(_playClick());
  }

  static Future<void> _playClick() async {
    try {
      await _player.stop();
      await _player.setSource(AssetSource('sounds/click.wav'));
      await _player.resume();
    } catch (_) {
      // Audio feedback is non-essential and must not block user interactions.
    }
  }
}
