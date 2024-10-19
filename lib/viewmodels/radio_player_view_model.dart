import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:iiiimusictv/vo_models/vo_station.dart';
import 'package:radio_player/radio_player.dart';
import 'package:video_player/video_player.dart';

class RadioPlayerViewModel extends ChangeNotifier {
  final _radioPlayer = RadioPlayer();

  bool _isPlaying = false;

  VideoPlayerController? controller;
  bool get isPlaying => _isPlaying;


  VOStation? get preStation {
    if (_stationList.isEmpty || _currentPos - 1 < 0) {
      return null;
    }
    return _stationList[_currentPos - 1];
  }
  VOStation? get currentStation {
    if (_stationList.isEmpty) {
      return null;
    }
    return _stationList[_currentPos];
  }
  VOStation? get nextStation {
    if (_stationList.isEmpty || _currentPos + 1 >= _stationList.length) {
      return null;
    }
    return _stationList[_currentPos + 1];
  }

  List<VOStation> _stationList = List.empty();
  Future<List<VOStation>> get stationList => Future((){
    return _stationList;
  });

  int _currentPos = 0;
  int get currentPos => _currentPos;

  RadioPlayerViewModel() {
    // _radioPlayer.setChannel(
    //   title: 'Radio Player',
    //   url: 'http://stream-uk1.radioparadise.com/aac-320',
    //   imagePath: 'assets/cover.jpg',
    // );
    _radioPlayer.stateStream.listen((value) {
      log("value#stateStream=$value}");
      _isPlaying = value;
      notifyListeners();
    });

    _radioPlayer.metadataStream.listen((value) {
      log("value#metadataStream=$value}");
    });
  }
  switchChannelByStation(List<VOStation> list, VOStation station) async {
    _currentPos = list.indexWhere((el) => el.stationUUID == station.stationUUID);
    _stationList = list;
    log("value#switchChannelByStation=${station.url}");
    notifyListeners();
    // await _radioPlayer.stop();
    // await _radioPlayer.setChannel(
    //   title: station.name,
    //   url: station.url,//'http://stream.laut.fm/1000-electronic-dance-music',
    //   // imagePath: 'assets/cover.jpg',
    // );
    // await _radioPlayer.play();
    // notifyListeners();
    controller?.dispose();
    controller = VideoPlayerController.networkUrl(Uri.parse(station.url),
    videoPlayerOptions: VideoPlayerOptions(
      allowBackgroundPlayback: true
    ));
    controller?.addListener(() {
      log("value#VideoPlayerController=${controller?.value.isPlaying}");
      if (null != controller?.value.errorDescription) {
        log("value#VideoPlayerController=${controller?.value.errorDescription}");
      }
    });
    await controller?.initialize();
    await controller?.play();
    notifyListeners();
  }
  switchChannel(String title, String url) async {
    await _radioPlayer.stop();
    await _radioPlayer.setChannel(
      title: title,
      url: url,//'http://stream.laut.fm/1000-electronic-dance-music',
      // imagePath: 'assets/cover.jpg',
    );
    await _radioPlayer.play();
    notifyListeners();
  }
  play() async {
    await _radioPlayer.stop();
    await _radioPlayer.setChannel(
      title: "test",
      // url: 'http://node-01.zeno.fm/bwrw9xcgqeruv',//no
      // url: 'https://cast3.server89.com/radio/8040/radio.mp3',//no
      // url: 'http://stream2.dimusic.club:11499/dim2?type=.aac',//no
      // url: 'https://play.cdn.enetres.net/56495F77FD124FECA75590A906965F2C024/024/playlist.m3u8',//no
      // url: 'http://stream.laut.fm/1000-electronic-dance-music',//no
      url: 'https://playerservices.streamtheworld.com/api/livestream-redirect/XHPSFMAAC.aac',//no
      // imagePath: 'assets/cover.jpg',
    );
    await _radioPlayer.play();
    log("value#play");
    notifyListeners();
  }

  pause() async {
    await _radioPlayer.pause();
    notifyListeners();
  }

  stop() async {
    await _radioPlayer.stop();
    notifyListeners();
  }
}
