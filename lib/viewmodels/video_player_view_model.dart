import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:iiiimusictv/vo_models/vo_station.dart';
import 'package:iiiimusictv/extensions/object_ext.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerViewModel extends ChangeNotifier {
  bool _isPlaying = false;

  VideoPlayerController? _controller;

  bool get isPlaying => _isPlaying;
  StreamController<bool> isPlayingController = StreamController.broadcast();
  StreamController<String> errorMsg = StreamController.broadcast();

  VOStation? get preStation {
    if (_stationList.isEmpty) {
      return null;
    }
    if (_currentPos - 1 < 0) {
      return _stationList[_stationList.length - 1];
    }
    return _stationList[_currentPos - 1];
  }

  // StreamController<VOStation?> currentStation = StreamController.broadcast();
  VOStation? get currentStation {
    if (_stationList.isEmpty) {
      return null;
    }
    return _stationList[_currentPos];
  }

  VOStation? get nextStation {
    if (_stationList.isEmpty) {
      return null;
    }
    if (_currentPos + 1 >= _stationList.length) {
      return _stationList[0];
    }
    return _stationList[_currentPos + 1];
  }

  List<VOStation> _stationList = List.empty();

  Future<List<VOStation>> get stationList => Future(() {
        return _stationList;
      });

  int _currentPos = 0;

  int get currentPos => _currentPos;

  VideoPlayerViewModel() {
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  switchChannel(VOStation station) async {
    log("value#switchChannelByStation=${station.url}");
    log("value#switchChannelByStation#favicon=${station.favicon}");
    notifyListeners();

    _controller?.dispose();
    _controller = VideoPlayerController.networkUrl(Uri.parse(station.url),
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true));
    _controller?.ifNotNull((it) async {
      it.addListener(() {
        _isPlaying = it.value.isPlaying;
        log("value#VideoPlayerController#caption=${it.value..caption}");
        it.value.errorDescription?.ifNotNull((error) {
          log("value#VideoPlayerController=$error");
          errorMsg.sink.add(error);
        });
        isPlayingController.sink.add(it.value.isPlaying);
        notifyListeners();
      });
      await it.initialize();
      await it.play();
    });
    notifyListeners();
  }

  switchChannelByStation(List<VOStation> list, VOStation station) async {
    _currentPos =
        list.indexWhere((el) => el.stationUUID == station.stationUUID);
    _stationList = list;
    log("value#switchChannelByStation=${station.url}");
    notifyListeners();

    switchChannel(station);
  }

  play() async {
    await _controller?.play();
    notifyListeners();
  }

  pause() async {
    await _controller?.pause();
    notifyListeners();
  }

  stop() async {
    await _controller?.dispose();
    notifyListeners();
  }

  playNext() async {
    if (_stationList.isEmpty) {
      return;
    }
    int next = _currentPos + 1;
    if (_stationList.length <= next) {
      next = 0;
    }
    _currentPos = next;
    currentStation.ifNotNull((station) {
      switchChannel(station);
    });
    notifyListeners();
  }

  playPre() async {
    if (_stationList.isEmpty) {
      return;
    }
    int next = _currentPos - 1;
    if (0 >= next) {
      next = _stationList.length - 1;
    }
    _currentPos = next;
    currentStation.ifNotNull((station) {
      switchChannel(station);
    });
    notifyListeners();
  }
}
