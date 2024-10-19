import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:iiiimusictv/repos/remote/api/dto/dto_radio_country.dart';
import 'package:iiiimusictv/repos/repo_api_services.dart';
import 'package:iiiimusictv/vo_models/vo_radio_country.dart';

class CountryListViewModel extends ChangeNotifier {
  List<VORadioCountry> _list = List.empty();

  List<VORadioCountry> get list => _list.where((el) {
        return el.countryName.toLowerCase().contains(searchText.toLowerCase());
      }).toList();
  String searchText = "";

  final RepoApiServices repo;

  CountryListViewModel(this.repo) {
    init();
  }

  void init() async {
    await repo.fetchCountryList().then((value) {
      return value.map((el) => el.toVORadioCountry()).toList();
    }).then((value) {
      _list = value;
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
}
