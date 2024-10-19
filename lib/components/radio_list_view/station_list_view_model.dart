import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:iiiimusictv/repos/remote/api/dto/dto_station.dart';
import 'package:iiiimusictv/repos/repo_api_services.dart';
import 'package:iiiimusictv/vo_models/vo_station.dart';
import 'package:iiiimusictv/tools/pair.dart';

class StationListInfoViewModel extends ChangeNotifier {
  StreamController<List<VOStation>> stationListController = StreamController.broadcast();
  List<VOStation> _allList = List.empty();
  List<VOStation> get _list => _allList.where((el) => el.name.trim().isNotEmpty).toList()..sort((a, b) => b.votes - a.votes);
  List<VOStation> get list => _list.where((el) {
        return el.name.toLowerCase().contains(searchText.toLowerCase());
      }).toList();
  List<VOStation> get allList => _list;
  StreamController<Pair<List<VOStation>, VOStation>> clickedStation = StreamController<Pair<List<VOStation>, VOStation>>();
  String searchText = "";

  int get allChannelCount => _allList.length;
  int get unknownChannelCount => _allList.length - _list.length;

  final RepoApiServices repo;
  final String countryName;
  final String countryCodeExact;

  StationListInfoViewModel(
      this.repo, this.countryName, this.countryCodeExact) {
    init();
  }

  @override
  void dispose() {
    stationListController.sink.close();
    stationListController.close();
    super.dispose();
  }

  void init() async {
    stationListController.stream.listen((onData) {
      _allList = onData;
      notifyListeners();
    });

    await repo
        .fetchStationListByCodeExact(countryCodeExact)
        .then((value) {
      return value.map((el) => el.toVOStation()).toList();
    }).then((value) {
      stationListController.sink.add(value);
      notifyListeners();
    }).catchError((error) {
      log("error:$error");
    });
  }

  void inputSearchText(String text) {
    searchText = text;
    notifyListeners();
  }

  void clearSearchText() {
    searchText = "";
    notifyListeners();
  }

  void onClickItem(VOStation data) {
    clickedStation.sink.add(Pair(list, data));
  }
}
