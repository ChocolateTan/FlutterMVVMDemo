import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

/**
 * https://pub.dev/packages/radio_player
 */
class AudioPlayerViewModel extends ChangeNotifier {
  final player = AudioPlayer();
  PlayerState _playerStateChanged = PlayerState.disposed;
  PlayerState get playerStateChanged => _playerStateChanged;

  AudioPlayerViewModel() {
    player.getDuration().then((value) {
      // log("value#getDuration=$value}");
    });
    player.getCurrentPosition().then((value) {
      // log("value#getCurrentPosition=$value}");
    });
    player.onPlayerStateChanged.listen((value) {
      log("value#onPlayerStateChanged=$value}");
      _playerStateChanged = value;
      notifyListeners();
    });
  }

  play() async {
    // await player.play(UrlSource("http://stream.laut.fm/1000-electronic-dance-music"));
    await player.play(UrlSource("https://phish.in/audio/000/000/003/3.mp3"));
  }

  resume() async {
    await player.resume();
  }

  pause() async {
    await player.pause();
  }

  stop() async {
    await player.stop();
  }

  destroyPlayer() async {
    await player.dispose();
  }
}